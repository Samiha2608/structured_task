class Post < ApplicationRecord
  validates :post_name, :post_detail, presence: true
  belongs_to :employee
  has_many :comments, as: :commentable
end
