FactoryBot.define do
  factory :member do
    trait :with_ads do
      after(:create) do |customer, evaluator|
        create_list(:ad, evaluator.qtt_orders, customer: customer)
      end
    end

    trait :with_valid_profile do
      association :profile_member, factory: :valid_profile, member: :member
    end

    trait :with_invalid_profile do
      association :profile_member, factory: :profile_member, member: :member
    end

    factory :customer_valid_without_ads, traits: [:with_valid_profile]
    factory :customer_valid_with_ads, traits: [:with_valid_profile, :with_ads]
    factory :customer_invalid, traits: [:with_invalid_profile]
  end
end
