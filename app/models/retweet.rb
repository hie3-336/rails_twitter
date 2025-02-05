# frozen_string_literal: true

class Retweet < ApplicationRecord
  belongs_to :tweet, counter_cache: true
  belongs_to :user

  has_one :timeline, dependent: :destroy

  validates :user_id, uniqueness: { scope: :tweet_id }
end
