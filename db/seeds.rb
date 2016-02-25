# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user1 = User.create(:email => 'admin@example.com', :password => 'helloworld', :password_confirmation => 'helloworld', :confirmed_at => Time.now)
user1.save!
user1.wikis.create(:title => 'Wiki 1', :body => 'wiki one stuff')
user1.wikis.create(:title => 'Wiki 2', :body => 'wiki two stuff')
p 'One user created'