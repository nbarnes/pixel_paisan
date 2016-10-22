class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.timestamps
      t.integer :user_id, index: true
      t.integer :gallery_id, index: true
      t.integer :snapshots_count
      t.timestamp :snapshot_updated_at
      t.string :name
    end
  end
end
