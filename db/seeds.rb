# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Marker.create!( :first => "System", :last => "Admin", :email => "admin@local.machine", :admin => true, :password => "chem1stry", :password_confirmation => "chem1stry", :scaling => 1.0, :shift => 0.0, :abbr => "SA")
