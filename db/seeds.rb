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
    encrypted_password: row['encryoted_password'],
    phone_number: row['phone_number'],
    birthday: row['birthday']
  )
  # item.image.attach(io: File.open("db/testimage/#{row['filename']}.jpg"), filename: "#{row['filename']}.png")
  user.save
end
