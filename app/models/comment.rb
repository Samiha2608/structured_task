class Comment < ApplicationRecord
  validates :content, presence: true
  belongs_to :commentable, polymorphic: true
  belongs_to :employee
end
