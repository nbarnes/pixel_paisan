class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.timestamps

      t.integer :user_id
      t.integer :gallery_id
      t.binary :png_data
      t.string :image_name
    end
  end
end
