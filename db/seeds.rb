# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

puts "Creating plans..."
csv_file = File.join(__dir__, 'jobs.csv')
plans = CSV.foreach(csv_file, headers: true).map do |row|
  Plan.create!(row)
end

puts "Creating new users and contracts..."
3.times do
  user = User.new(email: Faker::Internet.email, password: 123_456,
                  first_name: Faker::Artist.name,
                  last_name: Faker::Creature::Dog.name,
                  marital_status: Faker::Internet.slug(words: 'single'),
                  children: rand(1..8),
                  dob: Faker::Date.birthday(min_age: 18, max_age: 65),
                  budget: Faker::Number.decimal(l_digits: 4, r_digits: 2))
  user.save!

  contract = Contract.new(
    user: user,
    plan: plans.sample
  )
  contract.save!
  puts "Contracts saved correctly..."
end
