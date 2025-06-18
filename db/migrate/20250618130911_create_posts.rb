class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.string :post_name
      t.string :post_detail
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
