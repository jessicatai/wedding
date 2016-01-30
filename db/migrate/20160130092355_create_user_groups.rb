class CreateUserGroups < ActiveRecord::Migration
  def self.up
    create_table :user_groups do |t|
      t.string :code
      t.string :address
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :user_groups
  end
end
