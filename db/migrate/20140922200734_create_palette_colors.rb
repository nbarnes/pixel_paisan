class CreatePaletteColors < ActiveRecord::Migration
  def change
    create_table :palette_colors do |t|
      t.integer :palette_id, null: :false, index: true
      t.integer :color_id, null: :false, index: true
      t.timestamps
    end
  end
end
