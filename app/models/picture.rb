class Picture < ApplicationRecord
  validates :picture_name, :picture_caption, presence: true
  belongs_to :employee
  has_many :comments, as: :commentable
end
