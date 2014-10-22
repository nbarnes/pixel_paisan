class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|

      t.timestamps

      t.integer :user_id
      t.binary :png_data

    end
  end
end
