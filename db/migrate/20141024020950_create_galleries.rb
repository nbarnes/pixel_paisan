class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.timestamps, null: :false
      t.integer :user_id
    end
  end
end
