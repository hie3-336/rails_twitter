# frozen_string_literal: true

class Tweet < ApplicationRecord
  validates :tweet_text, length: { in: 1..140 }

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :comments, dependent: :destroy

  # 投稿画像
  has_one_attached :image
end
