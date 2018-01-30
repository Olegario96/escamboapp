namespace :utils do
  desc "Create fake admins"
  task generate_admins: :environment do
    puts 'Creating administrators...'
    10.times do
      Admin.create!(name: Faker::Name.name, email: Faker::Internet.email, password: '123456', password_confirmation: '123456', role: [0,1].sample)
    end
    puts 'Administrators created!'
  end

  desc "Creating fake ads"
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
