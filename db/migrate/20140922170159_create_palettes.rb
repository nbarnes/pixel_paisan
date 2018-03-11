class CreatePalettes < ActiveRecord::Migration
  def change
    create_table :palettes do |t|
      t.timestamps
      t.string :name, null: false
      t.boolean :is_default, index: true
      t.jsonb :colors
    end
  end
end
