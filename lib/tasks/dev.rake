namespace :dev do
  desc 'Setup development'
  task setup: :environment do
    puts 'Executing setup for development'
    puts "Deleting DB... #{%x(rake db:drop)}"
    if Rails.env.development?
      puts "Deleting images for public/system #{%x(rm -rf public/system/)}"
    end
    puts "Creating DB... #{%x(rake db:create)}"
    puts %x(rake db:migrate)
    puts %x(rake db:seed)
    puts %x(rake dev:generate_members)
    puts %x(rake dev:generate_ads)
    puts %x(rake dev:generate_admins)
    puts %x(rake dev:generate_comments)
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
      member = Member.new(
        email: Faker::Internet.email,
        password: '123456',
        password_confirmation: '123456'
      )
      member.build_profile_member
      member.profile_member.first_name = Faker::Name.first_name
      member.profile_member.second_name = Faker::Name.last_name
      member.save!
    end
    puts 'Members created!'
  end

  desc 'Creating fake ads'
  task generate_ads: :environment do
    puts 'Creating ads...'
    5.times do
      Ad.create!(
        title: Faker::Lorem.sentence([2,3,4,5].sample),
        description_md: markdown_fake,
        description_short: Faker::Lorem.sentence([2,3].sample),
        member: Member.first,
        category: Category.all.sample,
        price: "#{Random.rand(500)},#{Random.rand(99)}",
        finish_date: Date.today + Random.rand(90),
        picture: File.new(Rails.root.join('public', 'templates', 'images-for-ads', "#{Random.rand(9)}.jpg"), 'r')
      )
    end

    950.times do
      Ad.create!(
        title: Faker::Lorem.sentence([2,3,4,5].sample),
        description_md: markdown_fake,
        description_short: Faker::Lorem.sentence([2,3].sample),
        member: Member.all.sample,
        category: Category.all.sample,
        price: "#{Random.rand(500)},#{Random.rand(99)}",
        finish_date: Date.today + Random.rand(90),
        picture: File.new(Rails.root.join('public', 'templates', 'images-for-ads', "#{Random.rand(9)}.jpg"), 'r')
      )
    end

    puts 'Ads created!'
  end


  desc 'Creating comments'
  task generate_comments: :environment do
    puts 'Creating comments...'
    Ad.all.each do |ad|
      (Random.rand(3)).times do
        Comment.create!(
          body: Faker::Lorem.paragraph([1,2,3].sample),
          member: Member.all.sample,
          ad: ad
        )
      end
    end
    puts 'Comments created!'
  end

  def markdown_fake
    %x(ruby -e "require 'doctor_ipsum'; puts DoctorIpsum::Markdown.entry")
  end
end
