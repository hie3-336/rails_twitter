# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# require 'csv'

# CSV.foreach('db/seeds/user_seed.csv', headers: true) do |row|
#   user = User.create(
#     name: row['name'],
#     email: row['email'],
#     encrypted_password: row['encryoted_password'],
#     phone_number: row['phone_number'],
#     birthday: row['birthday']
#   )
#   # user.image.attach(io: File.open("db/testimage/#{row['filename']}.jpg"), filename: "#{row['filename']}.png")
#   user.save
# end

# CSV.foreach('db/seeds/tweet_seed.csv', headers: true) do |row|
#   tweet = Tweet.create(
#     user_id: row['user_id'],
#     tweet_text: row['tweet_text'],
#   )
#   tweet.image.attach(io: File.open("db/testimage/#{row['filename']}.jpg"), filename: "#{row['filename']}.png")
#   tweet.save

# end

user = User.create(name: 'テストユーザー', email: 'test@testtest.com', password: 'password', phone_number: '08000000000', birthday: '1993-11-10')
user.save!

tweet = Tweet.create(user_id: 1, tweet_text: 'テストツイートです！')
tweet.image.attach(io: File.open('db/testimage/test.png'), filename: 'test.png')
tweet.save!
