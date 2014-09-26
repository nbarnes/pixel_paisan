class CreatePaletteColors < ActiveRecord::Migration
  def change
    create_table :palette_colors do |t|

      t.integer :palette_id
      t.integer :color_id

      t.timestamps
    end
  end
end
