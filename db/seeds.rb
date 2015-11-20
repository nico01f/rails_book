# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name: "Example User", email: "example@memocit.ex", mobile_num: "56964257820", password: "foobar", password_confirmation: "foobar")

9.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@memocity.cl"
  mobile_num = "5696425781#{n}"
  password = "password"
  User.create!(name: name, email: email, mobile_num: mobile_num, password: password, password_confirmation: password)
end
