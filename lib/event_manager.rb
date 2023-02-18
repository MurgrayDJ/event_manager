require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
#puts 'Event Manager Initialized!'

#Prints entire file
# contents = File.read('event_attendees.csv')
# puts contents




#Reads each line into an array, then outputs them.
# lines = File.readlines('event_attendees.csv')
# lines.each do |line|
#   puts line
# end




#Prints first name of each entry
# lines = File.readlines('event_attendees.csv')
# lines.each do |line|
#   columns = line.split(",")
#   name = columns[2]
#   puts name
# end




#Prints first name of each entry, excluding the header
# lines = File.readlines('event_attendees.csv')
# lines.each_with_index do |line,index|
#   next if index == 0
#   columns = line.split(",")
#   name = columns[2]
#   puts name
# end




#Uses Ruby CSV library to read first names
# contents = CSV.open('event_attendees.csv', headers: true)
# contents.each do |row|
#   name = row[2]
#   puts name
# end




#Reads in file and converts header names to symbols
# contents = CSV.open(
#   'event_attendees.csv',
#   headers: true,
#   header_converters: :symbol
# )
  
# contents.each do |row|
#   name = row[:first_name]
#   puts name
# end




#Outputs the first name and zipcode
# contents = CSV.open(
#   'event_attendees.csv',
#   headers: true,
#   header_converters: :symbol
# )

# contents.each do |row|
#   name = row[:first_name]
#   zipcode = row[:zipcode]
#   puts "#{name} #{zipcode}"
# end



#Corrects formatting of zipcodes
# contents = CSV.open(
#   'event_attendees.csv',
#   headers: true,
#   header_converters: :symbol
# )

# contents.each do |row|
#   name = row[:first_name]
#   zipcode = row[:zipcode]

#   if zipcode.nil?
#     zipcode = '00000'
#   elsif zipcode.length < 5
#     zipcode = zipcode.rjust(5, '0')
#   elsif zipcode.length > 5
#     zipcode = zipcode[0..4]
#   end

#   puts "#{name} #{zipcode}"
# end



#Moves zip code functionality to a new method
# def clean_zipcode(zipcode)
#     if zipcode.nil?
#       '00000'
#     elsif zipcode.length < 5
#       zipcode.rjust(5, '0')
#     elsif zipcode.length > 5
#       zipcode[0..4]
#     else
#       zipcode
#     end
#   end
  
#   puts 'EventManager initialized.'
  
#   contents = CSV.open(
#     'event_attendees.csv',
#     headers: true,
#     header_converters: :symbol
#   )
  
#   contents.each do |row|
#     name = row[:first_name]
  
#     zipcode = clean_zipcode(row[:zipcode])
  
#     puts "#{name} #{zipcode}"
#   end




#Makes the zip code method simpler
# def clean_zipcode(zipcode)
#     zipcode.to_s.rjust(5, '0')[0..4]
# end




#Finds legislator by zipcode using Google API Client
# def clean_zipcode(zipcode)
#     zipcode.to_s.rjust(5, '0')[0..4]
#   end
  
#   def legislators_by_zipcode(zip)
#     civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
#     civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'
  
#     begin
#       legislators = civic_info.representative_info_by_address(
#         address: zip,
#         levels: 'country',
#         roles: ['legislatorUpperBody', 'legislatorLowerBody']
#       )
#       legislators = legislators.officials
#       legislator_names = legislators.map(&:name)
#       legislator_names.join(", ")
#     rescue
#       'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
#     end
#   end
  
#   puts 'EventManager initialized.'
  
#   contents = CSV.open(
#     'event_attendees.csv',
#     headers: true,
#     header_converters: :symbol
#   )
  
#   contents.each do |row|
#     name = row[:first_name]
  
#     zipcode = clean_zipcode(row[:zipcode])
  
#     legislators = legislators_by_zipcode(zipcode)
  
#     puts "#{name} #{zipcode} #{legislators}"
#   end

# template_letter = File.read('form_letter.html')



#Uses ERB template
# def clean_zipcode(zipcode)
#     zipcode.to_s.rjust(5,"0")[0..4]
#   end
  
#   def legislators_by_zipcode(zip)
#     civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
#     civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'
  
#     begin
#       civic_info.representative_info_by_address(
#         address: zip,
#         levels: 'country',
#         roles: ['legislatorUpperBody', 'legislatorLowerBody']
#       ).officials
#     rescue
#       'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
#     end
#   end
  
#   puts 'EventManager initialized.'
  
#   contents = CSV.open(
#     'event_attendees.csv',
#     headers: true,
#     header_converters: :symbol
#   )
  
#   template_letter = File.read('form_letter.erb')
#   erb_template = ERB.new template_letter
  
#   contents.each do |row|
#     name = row[:first_name]
  
#     zipcode = clean_zipcode(row[:zipcode])
  
#     legislators = legislators_by_zipcode(zipcode)
  
#     form_letter = erb_template.result(binding)
#     puts form_letter
#   end




#Final program, writes thank you letters to external files
# def clean_zipcode(zipcode)
#   zipcode.to_s.rjust(5,"0")[0..4]
# end
  
# def legislators_by_zipcode(zip)
#   civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
#   civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

#   begin
#     civic_info.representative_info_by_address(
#       address: zip,
#       levels: 'country',
#       roles: ['legislatorUpperBody', 'legislatorLowerBody']
#     ).officials
#   rescue
#     'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
#   end
# end
  
# def save_thank_you_letter(id,form_letter)
#   Dir.mkdir('output') unless Dir.exist?('output')

#   filename = "output/thanks_#{id}.html"

#   File.open(filename, 'w') do |file|
#     file.puts form_letter
#   end
# end
  
# puts 'EventManager initialized.'
  
# contents = CSV.open(
#   'event_attendees.csv',
#   headers: true,
#   header_converters: :symbol
# )
  
# template_letter = File.read('form_letter.erb')
# erb_template = ERB.new template_letter
  
# contents.each do |row|
#   id = row[0]
#   name = row[:first_name]
#   zipcode = clean_zipcode(row[:zipcode])
#   legislators = legislators_by_zipcode(zipcode)

#   form_letter = erb_template.result(binding)

#   save_thank_you_letter(id,form_letter)
# end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

def remove_punctuation(phone_number)
  clean_number = ''
  phone_number.each_char { |c|
    if /\A\d+\z/.match(c)
      clean_number += c
    end  
  }
  clean_number
end

def clean_phone_number(phone_number)
  phone_number = remove_punctuation(phone_number)
  if phone_number.nil?
    '0000000000'
  elsif phone_number.length < 10
    '0000000000'
  elsif phone_number.length == 11
    if phone_number[0] == '1'
      phone_number[1..10]
    else
      '0000000000'
    end
  elsif phone_number.length > 11
    '0000000000'
  else
    phone_number
  end
end

contents.each do |row|
  name = row[:first_name]

  phone_number = clean_phone_number(row[:homephone])
  phone_number = phone_number.insert(3, '-')
  phone_number = phone_number.insert(7, '-')

  puts "#{name} #{phone_number}"
end

