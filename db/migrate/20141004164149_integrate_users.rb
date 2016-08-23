class IntegrateUsers < ActiveRecord::Migration
  def change
    add_column :palettes, :user_id, :integer, null: false, index: true
    add_column :palettes, :is_default, :boolean, index: true
    add_column :users, :name, :string
    add_column :users, :role, :string
  end
end
