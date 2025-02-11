# frozen_string_literal: true

class BookmarksController < ApplicationController
  include FetchTweets
  before_action :authenticate_user!

  def index
    @bookmarked_tweets = fetch_tweets(current_user.bookmarks.pluck(:tweet_id))
  end
end
