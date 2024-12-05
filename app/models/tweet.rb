# frozen_string_literal: true

class Tweet < ApplicationRecord
  belong_to :user
end
