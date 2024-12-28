# frozen_string_literal: true

class Tweet < ApplicationRecord
  belongs_to :user

  # 投稿画像
  has_one_attached :image
end
