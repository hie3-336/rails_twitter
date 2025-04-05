FactoryBot.define do
  factory :timeline do
    association :user, factory: :user
    association :tweet, factory: :tweet
  end
end