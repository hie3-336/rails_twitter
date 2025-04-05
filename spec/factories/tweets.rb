FactoryBot.define do
  factory :tweet do
    content {"テストツイートです！"}
    association :user 
  end
end
