class AddTierToUserGroups < ActiveRecord::Migration
  def self.up
    add_column :user_groups, :tier, :integer
  end

  def self.down
    remove_column :user_groups, :tier
  end
end
