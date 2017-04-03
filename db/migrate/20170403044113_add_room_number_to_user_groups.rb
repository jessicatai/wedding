class AddRoomNumberToUserGroups < ActiveRecord::Migration
  def self.up
    add_column :user_groups, :room_number, :string, references: :lodgings
  end

  def self.down
    drop_column :user_groups, :room_number, :string, references: :lodgings
  end
end
