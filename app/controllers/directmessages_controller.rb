class DirectmessagesController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def show_chatroom
    @send_user_id = params[:send_user_id]
    @direct_messages = Directmessage.where(send_user_id: @send_user_id, receive_user_id: current_user.id)
    .or(Directmessage.where(send_user_id: current_user.id, receive_user_id: @send_user_id))
    render :index
  end

end
