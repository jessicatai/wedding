class User < ActiveRecord::Base
  belongs_to :user_group
  validates :first_name, :last_name, presence: true
  attr_accessible :diet, :email, :is_attending, :first_name, :last_name, :role
end
