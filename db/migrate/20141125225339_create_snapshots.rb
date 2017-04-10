
class CreateSnapshots < ActiveRecord::Migration
  def change
    create_table :snapshots do |t|
      t.timestamps
      t.integer :picture_id, null: false, index: true
      t.integer :cell_size, null: false

      t.jsonb :pixels, null: false
    end
  end
end
