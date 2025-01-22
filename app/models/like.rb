# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :tweet, counter_cache: true
  belongs_to :user

  validates :user_id, uniqueness: { scope: :tweet_id }
end
