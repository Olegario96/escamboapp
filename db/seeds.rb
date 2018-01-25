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
  Category.find_or_create_by(description: category)
end

puts 'Categories created!'

###############################################################################

puts 'Creating the administrator...'

Admin.create!(email: 'admin@admin.com', password: '123456', password_confirmation: '123456')

puts 'Administrator created!'
