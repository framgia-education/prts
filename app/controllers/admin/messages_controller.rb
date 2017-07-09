class Admin::MessagesController < ApplicationController
  before_action :verify_trainer!
  before_action :load_chatrooms, only: :new

  def new; end

  def create
    room_id = params[:chatroom_id]
    message = params[:message]

    message_service = MessageService.new message
    message = message_service.customize_message_content

    if ChatWork::Message.create room_id: room_id, body: "#{message}"
      flash[:success] = "Create message success!"
    else
      flash[:alert] = "Oops!!! Create message failed"
    end

    redirect_to new_admin_message_url
  end

  private

  def load_chatrooms
    @chatrooms = Chatroom.all
  end
end
