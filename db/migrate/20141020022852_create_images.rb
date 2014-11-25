class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.timestamps

      t.integer :user_id
      t.integer :gallery_id
      t.binary :png_blob
      t.binary :png_thumbnail_blob
      t.binary :png_display_blob
      t.string :name
    end
  end
end
