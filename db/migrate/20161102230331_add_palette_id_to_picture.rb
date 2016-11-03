class AddPaletteIdToPicture < ActiveRecord::Migration
  def change
    add_column :pictures, :palette_id, :integer
  end
end
