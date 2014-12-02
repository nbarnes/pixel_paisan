class CreateSnapshots < ActiveRecord::Migration
  def change
    create_table :snapshots do |t|

      t.timestamps
      t.integer :picture_id

    end

  end
end
