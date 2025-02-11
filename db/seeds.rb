# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'csv'

CSV.foreach('db/seeds/user_seed.csv', headers: true) do |row|
  user = User.create(
    name: row['name'],
    email: row['email'],
    password: row['password'],
    phone_number: row['phone_number'],
    birthday: row['birthday'],
    introduction: row['introduction'],
    place: row['place'],
    website: row['website'],
    confirmed_at: Time.zone.now
  )

  if row['h_filename'].present?
    user.profile_image.attach(io: File.open("db/testimage/#{row['h_filename']}.JPG"),
                              filename: "#{row['h_filename']}.jpg")
  end
  user.avater_image.attach(io: File.open("db/testimage/#{row['i_filename']}.JPG"), filename: "#{row['i_filename']}.jpg") if row['i_filename'].present?
  user.save!
end

CSV.foreach('db/seeds/tweet_seed.csv', headers: true) do |row|
  tweet = Tweet.create(
    user_id: row['user_id'],
    tweet_text: row['tweet_text']
  )
  tweet.image.attach(io: File.open("db/testimage/#{row['filename']}.jpg"), filename: "#{row['filename']}.png") if row['filename'].present?

  tweet.save!
  timeline = tweet.build_timeline(user: tweet.user)
  timeline.save!
end

CSV.foreach('db/seeds/follower_seed.csv', headers: true) do |row|
  follower = Follower.create(
    follower_id: row['follower_id'],
    followed_id: row['followed_id']
  )

  follower.save!
end

CSV.foreach('db/seeds/like_seed.csv', headers: true) do |row|
  like = Like.create(
    tweet_id: row['tweet_id'],
    user_id: row['user_id']
  )

  like.save!
end

CSV.foreach('db/seeds/retweet_seed.csv', headers: true) do |row|
  retweet = Retweet.create(
    tweet_id: row['tweet_id'],
    user_id: row['user_id']
  )

  retweet.save!
  timeline = retweet.build_timeline(user: retweet.user)
  timeline.save!
end

CSV.foreach('db/seeds/comment_seed.csv', headers: true) do |row|
  comment = Comment.create(
    tweet_id: row['tweet_id'],
    user_id: row['user_id'],
    comment_content: row['comment_content']
  )

  comment.save!
end

CSV.foreach('db/seeds/like_seed.csv', headers: true) do |row|
  bookmark = Bookmark.create(
    tweet_id: row['tweet_id'],
    user_id: row['user_id']
  )

  bookmark.save!
end

# 単一登録用
# user = User.create(name: 'テストユーザー', email: 'test@testtest.com', password: 'password', phone_number: '08000000000', birthday: '1993-11-10')
# user.save!

# tweet = Tweet.create(user_id: 1, tweet_text: 'テストツイートです！')
# tweet.image.attach(io: File.open('db/testimage/test.png'), filename: 'test.png')
# tweet.save!
