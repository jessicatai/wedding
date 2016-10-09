class AddRoleAndDietToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :role, :integer
    add_column :users, :diet, :string
  end

  def self.down
    remove_column :users, :diet
    remove_column :users, :role
  end
end
