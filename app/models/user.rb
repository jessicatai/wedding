class User < ActiveRecord::Base
  belongs_to :user_group
  validates :first_name, :last_name, presence: true
  attr_accessible :diet, :email, :is_attending, :first_name, :last_name, :role

  def as_json(options={})
    hash = super(options)
    hash['is_attending'] = hash['is_attending'] == true
    hash['first_name'] = default_empty_strings(hash['first_name'])
    hash['last_name'] = default_empty_strings(hash['last_name'])
    hash['email'] = default_empty_strings(hash['email'])
    hash
  end

  private
  def default_empty_strings(value)
    value.blank? ? '' : value
  end
end
