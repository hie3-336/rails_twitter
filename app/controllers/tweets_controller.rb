# frozen_string_literal: true

class TweetsController < ApplicationController
  def index
    @user = current_user
  end
end
