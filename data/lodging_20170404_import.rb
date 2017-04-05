#COPY lodgings(
#room_type, room_number, max_occupancy, num_beds, checkin_date, checkout_date)
#from '/Users/jessica_tai/Downloads/04-04-lodgings.csv' DELIMITER ',' CSV HEADER;

require 'csv'

PERSON_FIELDS = [
  'Person 1',
  'Person 2',
  'Person 3',
  'Person 4',
  'Person 5',
  'Person 6',
]

def import_lodging(is_dry_run = true, filename = '/Users/jessica_tai/Downloads/04-04-lodgings.csv')
  error_count = 0
  csv_text = File.read(filename)
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    room_number = row['room_number']
    PERSON_FIELDS.each do |person_field|
      if row[person_field].present?
        user = get_user(row[person_field])
        user_group = set_room_number_for_user(user, room_number)
        if user_group.present? && !is_dry_run
          user_group.save!
        end
      end
    end
  end
  puts "todo: Number of errors in this run: #{error_count}"
end

private
def set_room_number_for_user(user, room_number)
  if user.present?
    puts "Saving room for #{user.first_name}..."

    user_group = user.user_group
    return if user_group.blank?

    if user_group.room_number.present? && user_group.room_number != room_number
      puts "ERROR: Users in user group id #{user_group.id} are in multiple rooms"
      puts "(before: #{user_group.room_number}, after: #{room_number})"
    end

    user_group.room_number = room_number
    user_group
  end
end

def get_user(value)
  full_name = value.split(' ')
  first_name = full_name[0]
  last_name = full_name[1]
  users = User.where(:first_name => first_name, :last_name => last_name)

  if users.nil?
    puts "User not found for #{full_name}"
    return
  elsif users.length > 1
    puts "Multiple users for #{full_name}... skipping"
    return
  end
  users.first
end
