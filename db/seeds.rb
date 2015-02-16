# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
players=[
	["joey","joey_pass","1","8"],
	["nick","nick_pass","1","8"],
	["russel","russel_pass","1","7"],
	["vivek","vivek_pass","1","7"],
	["pritam","pritam_pass","1","6"],
	["amit","amit_pass","1","6"],
	["chandler","chandler_pass","1","5"],
	["colwin","colwin_pass","1","5"],
	["refree","refree_pass","0","0"]
]
players.each do |name,password,role,defence_set_length|
Player.create(name:name,password:password,role:role,defence_set_length:defence_set_length)
end