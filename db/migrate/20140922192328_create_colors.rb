class CreateColors < ActiveRecord::Migration
  def change
    create_table :colors do |t|

      t.timestamps

      t.integer :r, :g, :b
      t.float :a

    end
  end
end
