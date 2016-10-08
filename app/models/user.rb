class User < ActiveRecord::Base
  belongs_to :user_group
  validates :first_name, :last_name, presence: true
end
