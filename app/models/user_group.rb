class UserGroup < ActiveRecord::Base
  has_many :users
  accepts_nested_attributes_for :users
  belongs_to :lodgings, :foreign_key => 'room_number'
end
