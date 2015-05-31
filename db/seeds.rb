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

TaskStatus.create(
  [{ name: 'New' }, { name: 'In progress' }, { name: 'Done' }, { name: 'Closed' }, { name: 'Rejected' }]
)

TaskPriorityType.create(
  [{ name: 'Low' }, { name: 'Normal' }, { name: 'High' }, { name: 'Urgent' }, { name: 'Immediate' }]
)

PostCategory.create(
  [{ name: 'Movies' }, { name: 'Music' }, { name: 'Travels' }, { name: 'Food' }, { name: 'Clothes' }, { name: 'Books' }]
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

80.times do
  name = Faker::Lorem.sentence
  description = Faker::Lorem.paragraph(4)
  Task.create(
    name: name,
    description: description,
    progress: 0.step(100, 10).to_a.sample,
    status_id: rand(1..5),
    priority_id: rand(1..5),
    author_id: rand(1..8)
  )
end

60.times do
  title = Faker::Lorem.sentence
  body = Faker::Lorem.paragraph(7)
  Post.create(title: title, body: body, author_id: rand(1..8), category_id: rand(1..5))
end
