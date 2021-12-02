# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "destroying contracts"
Contract.destroy_all
puts "destroying users"
User.destroy_all
puts "destroying plans"
Plan.destroy_all

puts "creating new seeds"
3.times do
  user = User.new(email: Faker::Internet.email, password: 123_456,
                  first_name: Faker::Artist.name,
                  last_name: Faker::Creature::Dog.name,
                  marital_status: Faker::Internet.slug(words: 'single'),
                  children: rand(1..8),
                  dob: Faker::Date.birthday(min_age: 18, max_age: 65),
                  budget: Faker::Number.decimal(l_digits: 4, r_digits: 2))
  user.save!
  6.times do
    plan = Plan.new(
      provider: Faker::Company.name,
      price: rand(100..125),
      max_amount: rand(800..850),
      coverage_percent: rand(80..100),
      deductible: rand(75..100)
    )
    plan.save!

    puts "Plans saved correctly"
  end

  contract = Contract.new(
    user: user,
    plan: Plan.last
  )
  contract.save!
  puts "Contracts saved correctly"
end
