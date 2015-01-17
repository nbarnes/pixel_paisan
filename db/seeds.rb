# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :name => 'Admin', :email => 'pixel.paisan@gmail.com', :password => '4lw4ysTr14ngl3L3ft', :password_confirmation => '4lw4ysTr14ngl3L3ft', :role => 'admin'
puts 'New user created: ' << user.name