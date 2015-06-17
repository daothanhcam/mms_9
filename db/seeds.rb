# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(username: "nguyenhai", email: "nguyenhai1478@gmail.com", password: "123456789", role: "admin")
User.create!(username: "daothanhcam", email: "daothanhcam@gmail.com", password: "123123123", role: "admin")
User.create!(username: "guest1", email: "guest@gmail.com", password: "123123123", role: "member")
