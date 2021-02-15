# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string
#  password_digest :string
#  session_token   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: {minimum: 6}, allow_nil: true #rails needs to read password to validate it
    attr_reader :password #never makes tio db

    before_validation :ensure_session_token
    #OR after_initialize :ensure_session_token

    has_many :subs

    def self.find_by_credentials(username, password)
        user = User.find_by_username(username)
        return nil if user.nil?
        user.check_password(password) ? user : nil
    end

    
    def check_password(password)
        bcrypt_password= BCrypt::Password.new(self.password_digest)
        bcrypt_password.is_password?(password) #comes from BCrypt
    end
    
    def ensure_session_token
        self.session_token ||= SecureRandom.base64(64)
        # OR self.session_token = SecureRandom.urlsafe_base64
    end
    
    # def generate_session_token  HELPER METH
    #     SecureRandom.base64(64)
    # end
    
    def reset_sesssion_token!
        self.session_token = SecureRandom.urlsafe_base64
        self.save!
        self.session_token
    end

    private
    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end
end
