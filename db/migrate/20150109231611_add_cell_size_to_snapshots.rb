class AddCellSizeToSnapshots < ActiveRecord::Migration
  def change
    add_column :snapshots, :cell_size, :integer
  end
end
