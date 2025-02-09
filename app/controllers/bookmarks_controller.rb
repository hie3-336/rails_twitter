class BookmarksController < ApplicationController
  include FetchTweets
  before_action :authenticate_user!

  def show
    @bookmarked_tweets = fetch_tweets(current_user.bookmarks.pluck(:tweet_id))
  end
end
