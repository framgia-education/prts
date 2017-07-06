class Admin::MessagesController < ApplicationController
  before_action :verify_admin!

  def new
    @chatrooms = Chatroom.all
    @users = User.all
  end

  def create
    room = params[:chatroom_id]
    user_chatwork_account_id = params[:username_15]
    message = params[:message]
    ChatWork::Message.create room_id: room,
      body: "#{message}"
      # body: "[To:#{user_chatwork_account_id}]\n#{message}"
    redirect_to new_admin_message_url
  end
end
