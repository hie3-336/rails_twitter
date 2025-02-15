class DirectmessagesController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def show_chatroom
    @test = params[:send_user_id]

    render :index
  end

end
