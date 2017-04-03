class CreateLodgings < ActiveRecord::Migration
  def self.up
    create_table :lodgings do |t|
      t.string :room_number
      t.string :room_type
      t.integer :num_beds
      t.integer :max_occupancy
      t.date :checkin_date
      t.date :checkout_date

      t.timestamps
    end

    add_index :lodgings, :room_number
  end

  def self.down
    drop_table :lodgings
    drop_index :lodgings, :room_number
  end
end
