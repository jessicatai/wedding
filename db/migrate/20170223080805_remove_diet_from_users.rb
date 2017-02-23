class RemoveDietFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :diet
  end

  def self.down
    add_column :users, :diet, :string
  end
end
