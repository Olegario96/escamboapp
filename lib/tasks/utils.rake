namespace :utils do
  desc 'Setup development'
  task setup_dev: :environment do
    puts 'Executing setup for development'
    puts "Deleting DB... #{%x(rake db:drop)}"
    puts "Deleting images for public/system #{%x(rm -rf public/system/)}"
    puts "Creating DB... #{%x(rake db:create)}"
    puts %x(rake db:migrate)
    puts %x(rake db:seed)
    puts %x(rake utils:generate_members)
    puts %x(rake utils:generate_ads)
    puts %x(rake utils:generate_admins)
  end

  desc 'Create fake admins'
  task generate_admins: :environment do
    puts 'Creating administrators...'
    10.times do
      Admin.create!(name: Faker::Name.name, email: Faker::Internet.email, password: '123456', password_confirmation: '123456', role: [0,1].sample)
    end
    puts 'Administrators created!'
  end

  desc 'Creating members'
  task generate_members: :environment do
    puts 'Creating members...'
    100.times do
      Member.create!(
        email: Faker::Internet.email,
        password: '123456',
        password_confirmation: '123456'
      )
    end
    puts 'Members created!'
  end

  desc 'Creating fake ads'
  task generate_ads: :environment do
    puts 'Creating ads...'

    100.times do
      Ad.create!(
        title: Faker::Lorem.sentence([2,3,4,5].sample),
        description: LeroleroGenerator.paragraph(Random.rand(3)),
        member: Member.all.sample,
        category: Category.all.sample,
        price: "#{Random.rand(500)},#{Random.rand(99)}",
        picture: File.new(Rails.root.join('public', 'templates', 'images-for-ads', "#{Random.rand(9)}.jpg"), 'r')
      )
    end

    puts 'Ads created!'
  end
end
