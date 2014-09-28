class CreatePalettes < ActiveRecord::Migration
  def change
    create_table :palettes do |t|

      t.timestamps

      t.string :name, null: :false

    end
  end
end
