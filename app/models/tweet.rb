# frozen_string_literal: true

class Tweet < ApplicationRecord
  belongs_to :user
  has_many :like, dependent: :destroy
  has_many :retweet, dependent: :destroy
  has_many :comment, dependent: :destroy

  # 投稿画像
  has_one_attached :image
end
