class Timeline < ApplicationRecord
  belongs_to :user
  belongs_to :tweet, optional: true
  belongs_to :retweet, optional: true

end
