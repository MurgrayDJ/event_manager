require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'time'
puts 'Event Manager Initialized!'




#Write thank you letters
def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end
  
def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end
  
def save_thank_you_letter(id,form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end

  puts "thanks_#{id}.html created succesfully."
end

  
contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

def create_letters(contents) 
  template_letter = File.read('form_letter.erb')
  erb_template = ERB.new template_letter

  contents.each do |row|
    id = row[0]
    name = row[:first_name]
    zipcode = clean_zipcode(row[:zipcode])
    legislators = legislators_by_zipcode(zipcode)

    form_letter = erb_template.result(binding)

    save_thank_you_letter(id,form_letter)
  end
  puts "\nView output folder for successfully created letters."
end



###### Assignment 1 - Clean Phone Number ######
# puts 'EventManager initialized.'

# contents = CSV.open(
#   'event_attendees.csv',
#   headers: true,
#   header_converters: :symbol
# )

# def remove_punctuation(phone_number)
#   clean_number = ''
#   phone_number.each_char { |c|
#     if /\A\d+\z/.match(c)
#       clean_number += c
#     end  
#   }
#   clean_number
# end

# def clean_phone_number(phone_number)
#   phone_number = remove_punctuation(phone_number)
#   if phone_number.nil?
#     '0000000000'
#   elsif phone_number.length < 10
#     '0000000000'
#   elsif phone_number.length == 11
#     if phone_number[0] == '1'
#       phone_number[1..10]
#     else
#       '0000000000'
#     end
#   elsif phone_number.length > 11
#     '0000000000'
#   else
#     phone_number
#   end
# end

# contents.each do |row|
#   name = row[:first_name]

#   phone_number = clean_phone_number(row[:homephone])
#   phone_number = phone_number.insert(3, '-')
#   phone_number = phone_number.insert(7, '-')

#   puts "#{name} #{phone_number}"
# end



###### Assignment 2 - Time Targeting ######
# puts 'EventManager initialized.'

# contents = CSV.open(
#   'event_attendees.csv',
#   headers: true,
#   header_converters: :symbol
# )

# def create_hour_hash(contents)
#   hour_hash = Hash.new(0)
#   contents.each do |row|
#     date_time = Time.strptime(row[:regdate], "%m/%d/%Y %k:%M")
#     hour = date_time.hour
#     hour_hash[hour] += 1
#   end
#   print_hour_hash(hour_hash)
# end

# def print_hour_hash(hour_hash)
#   puts "Hour frequency hash:"
#   hour_hash.each do |key, value|
#     puts "#{key}:#{value}"
#   end
#   print_popular_hours(hour_hash)
# end

# def print_popular_hours(hour_hash)
#   puts "Most popular hours:"
#   hour_hash.each { |k, v| puts k if v == hour_hash.values.max }
# end

# create_hour_hash(contents)


###### Assignment 3 - Day of the Week Targeting ######
# puts 'EventManager initialized.'

# contents = CSV.open(
#   'event_attendees.csv',
#   headers: true,
#   header_converters: :symbol
# )

def create_day_hash(contents)
  day_hash = Hash.new(0)
  puts "\nDates with weekday: "
  contents.each do |row|
    date_time = Date.strptime(row[:regdate], "%m/%d/%y")
    weekday = Date::DAYNAMES[date_time.wday]
    puts "#{date_time} - #{weekday}"
    day_hash[weekday] += 1
  end
  print_day_hash(day_hash)
end

def print_day_hash(day_hash)
  puts "\nWeekday frequency hash:"
  day_hash.each do |key, value|
    puts "#{key}:#{value}"
  end
  print_popular_days(day_hash)
end

def print_popular_days(hour_hash)
  puts "\nMost popular weekday(s):"
  hour_hash.each { |k, v| puts k if v == hour_hash.values.max }
end








###### Data collection and validation ######
def get_valid_data(prompt, response, valid_responses) 
  if response.nil?
    print prompt
    response = gets.chomp
  else
    valid_responses.each do |valid_response|
      if response.downcase == valid_response.downcase
        return response
      elsif response.downcase == "exit"
        puts "Thank you for using the Event Manager."
        exit!
      elsif response.downcase == "help"
        print_actions
        break
      end
    end
    response = nil
  end
  response = get_valid_data(prompt, response, valid_responses)  
end

def choose_actions(choice, contents)
  case choice
  when "1"
    create_letters(contents)
  when "2"
  when "3"
  when "4"
    create_day_hash(contents)
  end
end

def print_actions(contents)
  puts "\nWhat would you like to accomplish today?"
  puts "  1. Send thank you letters"
  puts "  2. Get attendee phone numbers"
  puts "  3. Get most popular registration time data"
  puts "  4. Get most popular registration day data"
  action_prompt = "Please enter a number (1-4) for an action: "
  action_responses = %w(1 2 3 4)
  response = get_valid_data(action_prompt, nil, action_responses)
  choose_actions(response, contents)
end

print_actions(contents)