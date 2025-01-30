class Timeline < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  belongs_to :retweet
end
