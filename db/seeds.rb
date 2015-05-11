# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
UserGroup.create(
  [{ name: 'User' }, { name: 'Administrator' }, { name: 'Moderator' }, { name: 'Bloger' }]
)

User.create(
  username: 'Admin',
  email: 'admin@admin.com',
  password: 'admin123',
  admin: true,
  group_id: 2
)
99.times do
  username  = Faker::Internet.user_name
  email = Faker::Internet.free_email
  password  = 'password'
  User.create(username: username, email: email, password: password)
end
