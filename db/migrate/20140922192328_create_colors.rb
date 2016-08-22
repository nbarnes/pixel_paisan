class CreateColors < ActiveRecord::Migration
  def change
    create_table :colors do |t|
      t.timestamps, null: :false
      t.integer :r, :g, :b
      t.float :a
    end
  end
end
