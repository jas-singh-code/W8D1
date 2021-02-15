# == Schema Information
#
# Table name: post_subs
#
#  id         :bigint           not null, primary key
#  sub_id     :integer
#  post_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PostSub < ApplicationRecord
    belongs_to :post,
    foreign_key: :post_id,
    class_name: :Post

    belongs_to :sub,
    foreign_key: :sub_id,
    class_name: :sub
end
