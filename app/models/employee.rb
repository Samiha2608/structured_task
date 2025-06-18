class Employee < ApplicationRecord
  has_many :posts
  has_many :pictures
  has_many :subordinates, class_name: "Employee", foreign_key: "admin_id"

  # an employee can have one admin
  belongs_to :admin, class_name: "Employee", optional: true
end
