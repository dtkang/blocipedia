# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin_user = User.create(:email => 'admin@example.com', :password => 'helloworld', :password_confirmation => 'helloworld', :confirmed_at => Time.now, :role => 'admin')
admin_user.role = 'admin'
admin_user.save
admin_user.wikis.create(:title => 'Admin Private Wiki 1', :body => 'wiki one stuff', :private => true)
admin_user.wikis.create(:title => 'Admin Public Wiki 1', :body => 'wiki two stuff', :private => false)

standard_user = User.create(:email => 'standard@example.com', :password => 'helloworld', :password_confirmation => 'helloworld', :confirmed_at => Time.now, :role => 'standard')
standard_user.role = 'standard'
standard_user.save
standard_user.wikis.create(:title => 'Standard Public Wiki 1', :body => 'wiki one stuff', :private => false)
standard_user.wikis.create(:title => 'Standard Public Wiki 2', :body => 'wiki two stuff', :private => false)

premium_user = User.create(:email => 'premium@example.com', :password => 'helloworld', :password_confirmation => 'helloworld', :confirmed_at => Time.now, :role => 'premium')
premium_user.role = 'premium'
premium_user.save
premium_user.wikis.create(:title => 'Premium Private Wiki 1', :body => 'wiki one stuff', :private => true)
premium_user.wikis.create(:title => 'Premium Public Wiki 1', :body => 'wiki two stuff', :private => false)


p 'Three users created'