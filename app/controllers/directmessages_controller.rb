class DirectmessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @direct_message = Directmessage.new
  end

  def post_message
    @direct_message = Directmessage.new(directmessage_params)
    @direct_message.receive_user_id = params[:send_user_id]
    @direct_message.send_user_id = current_user.id
    if @direct_message.save
      redirect_to request.referer
    else
      redirect_to request.referer, alert: @direct_message.errors.full_messages
    end
  end

  def show_chatroom
    @direct_message = Directmessage.new
    @send_user = User.find_by(id: params[:send_user_id])
    @direct_messages = Directmessage.where(send_user_id: @send_user.id, receive_user_id: current_user.id)
    .or(Directmessage.where(send_user_id: current_user.id, receive_user_id: @send_user.id))
    render :index
  end

  private

  def directmessage_params
    params.require(:directmessage).permit(:message_content)
  end

end
