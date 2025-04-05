FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "Makigai#{n}" }
    sequence(:email) { |n| "makigai#{n}@test.com" }
    password { "password" }
    phone_number { "08000000000" }
    birthday { "2024-10-10" }
    confirmed_at { Time.zone.now }
  end
end
