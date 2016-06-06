# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'appt_data.csv'))
p csv_text
csv_text = csv_text.split("\n\n")
csv = []
csv_text.each do |x|
  csv << x.split(',')
end
csv.shift


csv.each do |column|
  a = Appointment.new
  a.start_time = column[0]
  a.end_time = column[1]
  a.first_name = column[2]
  a.last_name = column[3]
  a.comments = column[4] if column[4].nil? == false
  # a.day = a.start_as_datetime(:day)
  if a.save(validate: false)
    puts "#{a.first_name} #{a.last_name}'s appointment is saved."
    puts "Starts at #{a.start_time} and ends at #{a.end_time}"
    puts "-" * 20
  end
end