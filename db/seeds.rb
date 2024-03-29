# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#create a main sample user
User.create!(user_name: "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar")

99.times do |n|
    user_name = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(user_name: user_name,
        email: email,
        password:              password,
        password_confirmation: password)
    end

users = User.order(:created_at).take(6)
50.times do 
    title = Faker::Lorem.question(4)
    # title = Faker::Lorem.sentence(word_count: 4)
    description = Faker::Lorem.sentence(7)
    users.each   { |user| user.posts.create!(title: title, description: description) }
end


users = User.all
user = users.first
following = users[2..50]
followers = users[2..50]
following.each {|followed| user.follow(followed)}
followers.each {|follower| follower.follow(user)}


