class AddAdminIdToEmployees < ActiveRecord::Migration[7.2]
  def change
    add_column :employees, :admin_id, :integer
  end
end
