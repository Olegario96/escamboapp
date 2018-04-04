# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'Creating the categories...'
categories = ['Animals and accessories',
              'Sports',
              'For your home',
              'Eletronics and phones',
              'Music and hobbies',
              'Babys and kids',
              'Fashion and beauty',
              'Vehicles and boats',
              'Properties',
              'Jobs and business']

categories.each do |category|
  Category.friendly.find_or_create_by(description: category)
end

puts 'Categories created!'

###############################################################################

puts 'Creating the administrator...'

Admin.create!(name: 'Admin', email: 'admin@admin.com', password: '123456', password_confirmation: '123456', role: 0)

puts 'Administrator created!'

###############################################################################

puts 'Creating the default member...'

member = Member.create!(email: 'member@member.com', password: '123456', password_confirmation: '123456')
member.build_profile_member
member.profile_member.first_name = Faker::Name.first_name
member.profile_member.second_name = Faker::Name.last_name
member.save!

puts 'Default member created!'

puts 'Creating members...'
  1000.times do
    member = Member.create!(
      email: Faker::Internet.email,
      password: '123456',
      password_confirmation: '123456'
    )
  end
puts 'Members created!'
