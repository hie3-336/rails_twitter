# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :tweet
  belongs_to :user
end
