class AddLeaderUserIdToLodgings < ActiveRecord::Migration
  def self.up
    add_column :lodgings, :leader_user_id, :integer
  end

  def self.down
    remove_column :lodgings, :leader_user_id
  end
end
