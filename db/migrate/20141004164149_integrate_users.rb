class IntegrateUsers < ActiveRecord::Migration

  def change
    add_column :palettes, :user_id, :integer
    add_column :palettes, :is_default, :boolean

    add_column :users, :name, :string
  end

end
