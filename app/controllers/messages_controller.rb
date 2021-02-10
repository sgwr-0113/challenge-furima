class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.new(params.require(:message).permit(:user_id, :text, :room_id).merge(user_id: current_user.id))
      if @message.save
        ActionCable.server.broadcast 'message_channel', content: @message
      end
      redirect_to room_path(@message.room_id)
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
