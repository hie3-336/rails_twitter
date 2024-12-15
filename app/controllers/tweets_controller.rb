# frozen_string_literal: true

class TweetsController < ApplicationController
  def index
    @user = current_user
    @tweets = Tweet.with_attached_image.page(params[:page]).per(5)
    
  end
end
