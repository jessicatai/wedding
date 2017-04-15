class UserGroup < ActiveRecord::Base
  has_many :users
  accepts_nested_attributes_for :users
  belongs_to :lodgings, :foreign_key => 'room_number'

  def as_json(options={})
    hash = super(options)
    hash['lodging_saturday'] = default_false(hash['lodging_saturday'])
    hash['lodging_sunday'] = default_false(hash['lodging_sunday'])
    hash
  end

  private
  def default_false(value)
    value.blank? ? false : value
  end
end
