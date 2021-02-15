# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  title      :string
#  sub_id     :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Post < ApplicationRecord
#PostSub needs to extend one post to many subs
    belongs_to :sub,
        class_name: :Sub,
        foreign_key: :sub_id

    belongs_to :author,
        class_name: :user,
        foreign_key: :user_id

    has_many :postsubs
end
