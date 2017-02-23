class AddVegetarianCountToUserGroups < ActiveRecord::Migration
  def self.up
    add_column :user_groups, :vegetarian_count, :integer
  end

  def self.down
    remove_column :user_groups, :vegetarian_count
  end
end
