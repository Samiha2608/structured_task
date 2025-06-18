class CreatePictures < ActiveRecord::Migration[7.2]
  def change
    create_table :pictures do |t|
      t.string :picture_name
      t.string :picture_caption
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
