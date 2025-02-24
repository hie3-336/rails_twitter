# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :content, length: { in: 1..140 }

  belongs_to :tweet, counter_cache: true
  belongs_to :user
end
