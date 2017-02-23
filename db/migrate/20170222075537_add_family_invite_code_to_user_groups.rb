class AddFamilyInviteCodeToUserGroups < ActiveRecord::Migration
  def self.up
    add_column :user_groups, :family_invite, :string
  end

  def self.down
    remove_column :user_groups, :family_invite
  end
end
