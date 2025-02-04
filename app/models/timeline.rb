# frozen_string_literal: true

class Timeline < ApplicationRecord
  belongs_to :user
  belongs_to :tweet, optional: true
  belongs_to :retweet, optional: true
end
