class Employee < ApplicationRecord

  validates :name , presence: { message: "Name can't be blank" } , on:[:create, :update]
  validates :email, presence: {message: "Email cannot be empty" } , uniqueness: {message: "The email already exists" }, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "Email format is invalid" }, on: [:create, :update]
  validates :phone_no, length: { is: 11 } , numericality: { only_integer: true } , presence: true, uniqueness: true, on: [:create, :update]
  has_many :posts , before_add: :showing_info_before_post_add, after_add: :showing_info_after_post_add , before_remove: :showing_info_before_post_remove, after_remove: :showing_info_after_post_remove
  has_many :pictures, before_add: :showing_info_before_picture_add, after_add: :showing_info_after_picture_add, before_remove: :showing_info_before_picture_remove, after_remove: :showing_info_after_picture_remove
  validates_associated :posts, :pictures
  has_many :subordinates, class_name: "Employee", foreign_key: "admin_id"
  # an employee can have one admin
  belongs_to :admin, class_name: "Employee", optional: true
  before_validation :ensure_name_is_capitalized
  before_save :check_email_format

  before_create :showing_info_before_creation
  around_create :about_to_create_record
  after_create :showing_info_after_creation

  before_update :showing_info_before_update
  around_update :about_to_update_record
  after_update :showing_info_after_update

  before_destroy :showing_info_before_destroy
  around_destroy :about_to_destroy_record
  after_destroy :showing_info_after_destroy


  private
  def ensure_name_is_capitalized
    self.name= name&.capitalize()
  end
  def check_email_format
    unless email =~ /\A[^@\s]+@[^@\s]+\z/
      errors.add(:email, "Email format is invalid")
      Rails.logger.info("Invalid email format for #{email}")
      throw(:abort)  # Prevent saving if the email format is invalid
    end
  end
  def showing_info_before_creation
    Rails.logger.info("About to create a new employee record: #{self.name}")
  end
  def about_to_create_record
    Rails.logger.info("Starting the creation of employee record: #{self.name}")
    yield
    Rails.logger.info("Finished creating employee record: #{self.name}")
  end
  def showing_info_after_creation
    Rails.logger.info("Successfully created a new employee record: #{self.name}")
  end

  def showing_info_before_update
    Rails.logger.info("About to update employee record: #{self.name}")
  end
  def about_to_update_record
    Rails.logger.info("Starting the update of employee record: #{self.name}")
    yield
    Rails.logger.info("Finished updating employee record: #{self.name}")
  end
  def showing_info_after_update 
    Rails.logger.info("Successfully updated employee record: #{self.name}")
  end
  def showing_info_before_destroy
    Rails.logger.info("About to destroy employee record: #{self.name}")
  end
  def about_to_destroy_record
    Rails.logger.info("Starting the destruction of employee record: #{self.name}")
    yield
    Rails.logger.info("Finished destroying employee record: #{self.name}")
  end
  def showing_info_after_destroy
    Rails.logger.info("Successfully destroyed employee record: #{self.name}")
  end

  def showing_info_before_post_add(post)
    Rails.logger.info("About to add a post: #{post.post_name} to employee: #{self.name}")
  end
  def showing_info_after_post_add(post)
    Rails.logger.info("Successfully added post: #{post.post_name} to employee: #{self.name}")
  end
  def showing_info_before_post_remove(post)
    Rails.logger.info("About to remove post: #{post.post_name} from employee: #{self.name}")
  end
  def showing_info_after_post_remove(post)
    Rails.logger.info("Successfully removed post: #{post.post_name} from employee: #{self.name}")
  end
  def showing_info_before_picture_add(picture)
    Rails.logger.info("About to add a picture: #{picture.picture_name} to employee: #{self.name}")
  end
  def showing_info_after_picture_add(picture)
    Rails.logger.info("Successfully added picture: #{picture.picture_name} to employee: #{self.name}")
  end
  def showing_info_before_picture_remove(picture)
    Rails.logger.info("About to remove picture: #{picture.picture_name} from employee: #{self.name}")
  end
  def showing_info_after_picture_remove(picture)
    Rails.logger.info("Successfully removed picture: #{picture.picture_name} from employee: #{self.name}")
  end
end