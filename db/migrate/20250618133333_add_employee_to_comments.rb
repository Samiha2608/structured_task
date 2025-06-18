class AddEmployeeToComments < ActiveRecord::Migration[7.2]
  def change
    add_reference :comments, :employee, null: false, foreign_key: true
  end
end
