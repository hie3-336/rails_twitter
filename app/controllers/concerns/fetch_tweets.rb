module FetchTweets
  extend ActiveSupport::Concern

  private
  
  def fetch_tweets(tweet_ids)
    Tweet.where(id: tweet_ids)
         .with_attached_image.page(params[:page]).per(5)
         .includes(user: { avater_image_attachment: :blob })
         .order(created_at: :desc)
  end
  
end