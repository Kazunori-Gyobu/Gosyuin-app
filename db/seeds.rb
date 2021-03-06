# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: "山田太郎",
email: "yamada@example.com",
profile: "はじめまして！私も御朱印管理アプリをはじめました！",
password: "foobar",
password_confirmation: "foobar",
confirmed_at: Time.now)

99.times do
  User.create!(
    name: Faker::Japanese::Name.name,
    email: Faker::Internet.email,
    profile: Faker::Lorem.sentence,
    password: "password",
    password_confirmation: "password",
    confirmed_at: Time.now
  )
end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.posts.create!(content: content) }
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }