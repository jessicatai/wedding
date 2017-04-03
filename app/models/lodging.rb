class Lodging < ActiveRecord::Base
  has_many :user_groups, foreign_key: 'room_number'
end
