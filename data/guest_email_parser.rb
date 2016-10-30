# Google contact exported csv doesn't play nice with ruby's CSV parser
name_to_email_map = {}

puts "Parsing Google contacts..."
filename = ARGV.first
file = open(filename)
file.each do |line|
  line_utf8 = line
  unless line.valid_encoding?
    line_utf8 = line.encode("UTF-16be", :invalid=>:replace, :replace=>"?").encode('UTF-8')
    line_utf8.gsub(/dr/i,'med')
  end
  columns = line_utf8.split(',')
  emails = [columns[14], columns[15], columns[16]]
  full_name = "#{columns[0]} #{columns[2]}"
  name_to_email_map[full_name] = emails.compact.reject(&:empty?).join(",")
end
output = File.open( "invite_with_email.csv", "w" )

puts "Parsing invite list..."
filename = ARGV[1]
file = open(filename)
file.each_with_index do |line|
  columns = line.split(',')
  full_name = "#{columns[0]} #{columns[1]}"
  email = name_to_email_map[full_name]
  if email
    columns[2] = email
  end
  output << columns.join(',')
end
output.close
