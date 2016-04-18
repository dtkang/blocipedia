
admin_user = User.create(:email => 'admin@example.com', :password => 'helloworld', :password_confirmation => 'helloworld', :confirmed_at => Time.now, :role => 'admin')
admin_user.role = 'admin'
admin_user.save
admin_user.wikis.create(:title => 'Admin Private Wiki 1', :body => 'wiki one stuff', :private => true, :user_id => admin_user.id)
admin_user.wikis.create(:title => 'Admin Public Wiki 1', :body => 'wiki two stuff', :private => false, :user_id => admin_user.id)

standard_user = User.create(:email => 'standard@example.com', :password => 'helloworld', :password_confirmation => 'helloworld', :confirmed_at => Time.now, :role => 'standard')
standard_user.role = 'standard'
standard_user.save
standard_user.wikis.create(:title => 'Standard Public Wiki 1', :body => 'wiki one stuff', :private => false, :user_id => standard_user.id)
standard_user.wikis.create(:title => 'Standard Public Wiki 2', :body => 'wiki two stuff', :private => false, :user_id => standard_user.id)

premium_user = User.create(:email => 'premium@example.com', :password => 'helloworld', :password_confirmation => 'helloworld', :confirmed_at => Time.now, :role => 'premium')
premium_user.role = 'premium'
premium_user.save
premium_user.wikis.create(:title => 'Premium Private Wiki 1', :body => 'wiki one stuff', :private => true, :user_id => premium_user.id)
premium_user.wikis.create(:title => 'Premium Public Wiki 1', :body => 'wiki two stuff', :private => false, :user_id => premium_user.id)


p 'Three users created'