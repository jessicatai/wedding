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

def import_lodging(filename, is_dry_run = true)
  error_count = 0
  csv_text = File.read(filename)
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    room_number = row['Room number']
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

def set_leader_user(filename, is_dry_run = true)
  num_unassigned_rooms = 0

  csv_text = File.read(filename)
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    room_number = row['Room number']
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

def set_checkin_out_dates(filename, is_dry_run = true)
  num_rooms_without_dates = 0

  csv_text = File.read(filename)
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    room_number = row['Room number']
    checkin = row['Arrival']
    checkout = row['Departure']
    leader_name = row[LEADER_USER]

    if checkin.nil? || checkout.nil?
      puts "ERROR: room number #{room_number} with leader #{leader_name} has no dates"
      num_rooms_without_dates += 1
      next
    end

    PERSON_FIELDS.each do |person_field|
      if row[person_field].present?
        user = get_user(row[person_field])
        lodging = set_dates_for_lodging(user, leader_name, checkin, checkout)
        if lodging.present? && !is_dry_run
          lodging.save!
        end
      end
    end
  end

  puts "Finished with #{num_rooms_without_dates} rooms with no dates."

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

    puts "SAVING.... #{user.first_name}'s group to room number #{room_number}"
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

def assign_leader_to_room(user, room_number, is_dry_run=true)
  if user.present?
    lodging = Lodging.find_by_room_number(room_number)
    puts "user id #{user.id}"
    lodging.leader_user_id = user.id

    puts "SAVING.... #{user.first_name} as leader to lodging #{room_number}"
    lodging.save! if !is_dry_run

    puts "Assigned room number #{room_number} to #{user.first_name} #{user.last_name}"
  else
    puts "No user for assigned room #{room_number}"
  end
end

def set_dates_for_lodging(user, leader_name, checkin, checkout)
  return if user.blank? || user.user_group.blank?

  begin
    user_group = user.user_group

    leader = get_user(leader_name)
    leaders_user_group = leader.user_group

    lodging = Lodging.where(:room_number => user_group.room_number).first

    leader_user_nights = get_nights(leaders_user_group)
    requested_nights = get_nights(user_group)

    if leader_user_nights != requested_nights
      puts "ERROR: leader #{leader.first_name} night do not match #{user.first_name}"
    end

    rsvp_checkin = Date.strptime(requested_nights.first[:date], "%m/%d/%y")
    rsvp_checkout =  Date.strptime(requested_nights.last[:date], "%m/%d/%y")

    if Date.strptime(checkin, "%m/%d/%y") != rsvp_checkin
      puts "ERROR: checkin date does not match for #{user.first_name} (recorded: #{checkin}, requested: #{rsvp_checkin})"
    elsif Date.strptime(checkout, "%m/%d/%y")!= (rsvp_checkout + 1.day)
      puts "ERROR: checkout date does not match for #{user.first_name} (recorded: #{checkout}, requested: #{rsvp_checkout})"
    else
      lodging.checkin_date = rsvp_checkout
      lodging.checkout_date = rsvp_checkin
    end
  rescue => e
    puts "RESCUED: #{e}"
    return
  end

  lodging
end

def get_nights(user_group)
  nights = [
    { :date => '9/1/17', :requested => user_group.lodging_friday },
    { :date => '9/2/17', :requested => user_group.lodging_saturday },
    { :date => '9/3/17', :requested => user_group.lodging_sunday },
  ]

  nights.select{ |night| night[:requested].present? }
end
