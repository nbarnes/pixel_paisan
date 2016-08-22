
class CreateSnapshots < ActiveRecord::Migration
  def change
    create_table :snapshots do |t|
      t.timestamps, null: :false
      t.integer :picture_id, null: false
      t.integer :cell_size, null: false

      t.integer :original_png_width, null: false
      t.integer :original_png_height, null: false

      t.binary :original_png_blob, null: false
      t.binary :thumbnail_png_blob, null: false
      t.binary :display_png_blob, null: false
    end
  end
end
