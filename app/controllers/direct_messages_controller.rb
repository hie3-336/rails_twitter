# frozen_string_literal: true

class DirectMessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @direct_message = DirectMessage.new
  end

  def post_message
    @direct_message = DirectMessage.new(direct_message_params)
    @direct_message.receive_user_id = params[:send_user_id]
    @direct_message.send_user_id = current_user.id
    if @direct_message.save
      redirect_to request.referer
    else
      redirect_to request.referer, alert: @direct_message.errors.full_messages
    end
  end

  def show_chatroom
    @direct_message = DirectMessage.new
    @send_user = User.find_by(id: params[:send_user_id])

    # フォロワーかどうか判定し、異なる場合はDMメニューにリダイレクトさせてチャットルームを表示させない
    if current_user.followers.pluck(:id).include?(@send_user.id)
      @direct_messages = DirectMessage.where(send_user_id: @send_user.id, receive_user_id: current_user.id)
                                      .or(DirectMessage.where(send_user_id: current_user.id, receive_user_id: @send_user.id))
      render :index
    else
      redirect_to direct_messages_path, alert: 'フォロワーでない場合はメッセージを送ることができません'
    end
  end

  private

  def direct_message_params
    params.require(:direct_message).permit(:content)
  end
end
