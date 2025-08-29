# frozen_string_literal: true

FactoryBot.define do
  factory :tweet do
    content { 'テストツイートです！' }
    association :user
  end
end
