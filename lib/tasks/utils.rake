namespace :utils do
  desc "Create fake admins"
  task generate_admins: :environment do
    puts 'Creating administrators...'
    10.times do
      Admin.create!(name: Faker::Name.name, email: Faker::Internet.email, password: '123456', password_confirmation: '123456')
    end
    puts 'Administrators created!'
  end
end
