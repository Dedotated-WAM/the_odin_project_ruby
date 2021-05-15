require "csv"
require "google/apis/civicinfo_v2"
require "erb"
require "phone"
require "time"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
  # above is single line code for the below
  # if zipcode.nil?
  #   zipcode = "00000"
  # elsif zipcode.length < 5
  #   zipcode.insert(0, "0") while zipcode.length < 5
  # elsif zipcode.length > 5
  #   zipcode = zipcode[0..4]
  # else
  #   zipcode
  # end
end

def clean_phone_number(phone_number)
  number_length = phone_number.length
  if number_length == 11 && phone_number[0] == "1"
    phone_number = phone_number[1..0]
  elsif phone_number.nil? || number_length < 10 || number_length > 11 || (number_length == 11 && phone_number[0] != 1)
    "bad #"
  end

  begin
    Phoner::Phone.parse(phone_number, country_code: "1").format(:us)
  rescue StandardError
    "bad #"
  end
end

def legislators_by_zipcode(zipcode)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = "AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw"

  begin
    legislators = civic_info.representative_info_by_address(
      address: zipcode,
      levels: "country",
      roles: %w[legislatorUpperBody legislatorLowerBody]
    ).officials
  rescue StandardError
    "You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officals"
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir("output") unless Dir.exist?("output")
  filename = "output/thanks_#{id}.html"

  File.open(filename, "w") do |file|
    file.puts form_letter
  end
end

def generate_emails
  contents = CSV.open("event_attendees.csv", headers: true, header_converters: :symbol)
  template_letter = File.read("form_letter.erb")
  erb_template = ERB.new(template_letter)

  contents.each do |row|
    id = row[0]
    name = row[:first_name]
    zipcode = clean_zipcode(row[:zipcode])
    phone_number = clean_phone_number(row[:homephone])
    legislators = legislators_by_zipcode(zipcode)

    form_letter = erb_template.result(binding)

    save_thank_you_letter(id, form_letter)
  end
end

def highest_registrations_hour
  contents = CSV.open("event_attendees.csv", headers: true, header_converters: :symbol)
  dates = []
  hours = []

  contents.each do |row|
    date_time = Date._strptime(row[:regdate], "%m/%d/%y %H:%M")
    dates.push(date_time)
  end

  dates.each do |hash|
    hours.push(hash[:hour])
  end

  puts "The most registrations (#{hours.tally.values.max}) occurred when the hour was #{hours.tally.key(hours.tally.values.max)}:00 ."
end

def highest_registrations_weekday
  weekdays = []

  contents = CSV.open("event_attendees.csv", headers: true, header_converters: :symbol)
  dates = []

  contents.each do |row|
    date_time = Date.strptime(row[:regdate], "%m/%d/%y %H:%M")
    dates.push(date_time)
  end

  weekdays = []
  dates.each do |date|
    weekdays.push(date.strftime("%A"))
  end

  puts "The day with the most registrations is #{weekdays.tally.key(weekdays.tally.values.max)}."
end

unless File.exist?("event_attendees.csv")
  puts "Error. File does not exist."
  return
end

puts "EventManager Initialized!"
generate_emails
highest_registrations_hour
highest_registrations_weekday
