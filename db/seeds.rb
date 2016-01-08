# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create these test users with this command:
# rake db:seed
puts 'Creating test users'
test_users = [ 'test@test.com', 'test2@test.com' ]
test_users.each do |email|
    User.create!(email: email, password: 'testtest', password_confirmation: 'testtest') unless User.find_by_email(email).present?
end
