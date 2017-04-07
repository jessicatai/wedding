class Lodging < ActiveRecord::Base
  has_many :user_groups, foreign_key: 'room_number'
  belongs_to :user, :foreign_key => 'leader_user_id'
end
