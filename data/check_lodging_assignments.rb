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

LEADER_USER = 'Person 1'

def run_db_validations(filename, is_dry_run = true)
  error_count = 0
  room_leaders = {}
  csv_text = File.read(filename)
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    room_number = row['Room number']
    PERSON_FIELDS.each do |person_field|
      if row[person_field].present?
        user = get_user(row[person_field])
        user_group = check_room_number_for_user_group(user, room_number)

        if user_group.present?
          room_leaders = check_lodging(user_group, room_leaders)
        end

        # if user_group.present? && !is_dry_run
        #   user_group.save!
        # end
      end
    end
  end
  puts "todo: Number of errors in this run: #{error_count}"
end

def set_leader_user(is_dry_run = true, filename)
  num_unassigned_rooms = 0

  csv_text = File.read(filename)
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    room_number = row['room_number']
    leader_name = row[LEADER_USER]
    if leader_name.present?
      user = get_user(leader_name)
      assign_leader_to_room(user, room_number, is_dry_run)
    else
      num_unassigned_rooms += 1
    end
  end
  puts "Finished with #{num_unassigned_rooms} unassigned rooms."
end

private
def check_room_number_for_user_group(user, room_number)
  if user.present?
    puts "CHECKING room for #{user.first_name}..."

    user_group = user.user_group
    if user_group.blank?
      puts "ERROR: no user group for #{user.first_name}. Skipping..."
      return
    end

    if user_group.room_number.present? && user_group.room_number != room_number
      puts "ERROR: Users in user group id #{user_group.id} are in multiple rooms"
      puts "(before: #{user_group.room_number}, after: #{room_number})"
    end


    #user_group.room_number = room_number
    user_group
  end
end

def check_lodging(user_group, room_leaders)
  room_number = user_group.room_number
  lodging = Lodging.where(:room_number => room_number)

  if lodging.blank?
    puts "ERROR: no lodging for #{user_group.room_number}, user group #{user_group.id}"
    return room_leaders
  end

  lodging = lodging.first

  leader_user_id = lodging.leader_user_id
  if leader_user_id.blank?
    puts "ERROR: no leader assigned for #{lodging.room_number}"
    return room_leaders
  end

  leader = User.find(leader_user_id)

  if room_leaders[room_number].present?
    if room_leaders[room_number] != lodging.leader_user_id
      puts "ERROR: leader user id ##{leader_user_id} (#{leader.first_name} #{leader.last_name}) already a leader"
      puts "(before: #{room_leaders[leader_user_id]}, after: #{lodging.room_number})"
    end
  else
    room_leaders[room_number] = lodging.leader_user_id
  end
  room_leaders
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

def assign_leader_to_room(user, room_number, is_dry_run=true)
  if user.present?
    lodging = Lodging.find_by_room_number(room_number)
    puts "user id #{user.id}"
    lodging.leader_user_id = user.id

    lodging.save! if !is_dry_run

    puts "Assigned room number #{room_number} to #{user.first_name} #{user.last_name}"
  else
    puts "No user for assigned room #{room_number}"
  end
end
