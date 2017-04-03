module Rsvp
  module Constants
    USER_GROUP_PUBLIC_READ_FIELDS = [
      :address_line1,
      :address_line2,
      :city,
      :code,
      :id,
      :lodging_friday,
      :lodging_saturday,
      :lodging_sunday,
      :notes,
      :state,
      :tier,
      :vegetarian_count,
      :zipcode,
    ]

    USER_PUBLIC_READ_FIELDS = [
      :email,
      :first_name,
      :id,
      :is_attending,
      :last_name,
      :user_group,
    ]

    LODGING_PUBLIC_READ_FIELDS = [
      :room_type,
      :room_number,
      :num_beds,
      :max_occupancy,
      :checkin_date,
      :checkout_date,
    ]

    USER_GROUP_PUBLIC_WRITE_FIELDS = [
      :address_line1,
      :address_line2,
      :city,
      :lodging_friday,
      :lodging_saturday,
      :lodging_sunday,
      :notes,
      :state,
      :vegetarian_count,
      :zipcode,
    ]

    USER_PUBLIC_WRITE_FIELDS = [
      :email,
      :is_attending,
      :relationship,
      :user_group,
    ]

    LODGING_PUBLIC_WRITE_FIELDS = [
    ]
  end
end
