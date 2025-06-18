class Picture < ApplicationRecord
  belongs_to :employee
  has_many :comments, as: :commentable
end
