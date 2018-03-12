FactoryBot.define do
  factory :profile_member do
    birthdate { Faker::Date.between(2.days.ago, Date.today) }


    trait :non_blank_profile_for_member do
      first_name { Faker::Name.first_name }
      second_name { Faker::Name.last_name }
    end

    factory :non_blank_profile, traits: [:non_blank_profile_for_member]
  end
end
