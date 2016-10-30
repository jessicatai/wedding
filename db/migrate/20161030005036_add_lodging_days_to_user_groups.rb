class AddLodgingDaysToUserGroups < ActiveRecord::Migration
  def self.up
    add_column :user_groups, :lodging_friday, :string
    add_column :user_groups, :lodging_saturday, :string
    add_column :user_groups, :lodging_sunday, :string
  end

  def self.down
    remove_column :user_groups, :lodging_friday
    remove_column :user_groups, :lodging_saturday
    remove_column :user_groups, :lodging_sunday
  end
end
