# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Deleting all data and resetting primary key IDs"
Rake::Task['db:migrate:reset'].invoke
puts "Done"

puts "Creating single Review entry"
Review.create [{:id => '1',
			   :author => 'Richard Ortega',
			   :author_location => 'San Antonio, TX',
			   :recommend => 'Yes',
			   :rating => '5',
			   :comment => 'Loved the food at Zinc, it was amazing!',
			   :date => '2001-02-03T03:04:05+03:00',
			   :link => 'biz/zinc-bistro-and-wine-bar-san-antonio',
			   :location_id => '1'}]
puts "Review Data - Done"

puts "Creating single Location entry"
Location.create [{:id => '1',
			   :address_line_1 => '207 North Presa',
			   :address_line_2 => '',
			   :address_line_3 => '',
			   :city => 'San Antonio',
			   :state => 'TX',
			   :zip => '78205',
			   :phone_number_1 => '(210) 224-2900',
			   :phone_number_2 => '',
			   :phone_number_3 => '',
			   :name => 'Zinc Bistro & Wine Bar',
			   :url => '/biz/zinc-bistro-and-wine-bar-san-antonio'}]
puts "Location Data - Done"
