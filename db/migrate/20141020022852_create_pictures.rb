class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.timestamps
      t.integer :user_id
      t.integer :gallery_id
      t.string :name
    end
  end
end
