
class CreateSnapshots < ActiveRecord::Migration
  def change
    create_table :snapshots do |t|
      t.timestamps
      t.integer :picture_id
      t.string :encoded_original_png
      t.string :encoded_thumbnail_png
      t.string :encoded_display_png
    end
  end
end
