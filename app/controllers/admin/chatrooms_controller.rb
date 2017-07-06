class Admin::ChatroomsController < ApplicationController
  before_action :verify_admin!
  before_action :load_chatroom, only: [:edit, :update, :destroy]

  def index
    @chatrooms = Chatroom.all
    @chatroom = Chatroom.new
  end

  def create
    @chatroom = Chatroom.new chatroom_params

    if @chatroom.save
      flash[:success] = "Create chatroom success!"
    else
      flash[:alert] = "Oops!!! Create chatroom failed"
    end
    redirect_to admin_chatrooms_url
  end

  def edit; end

  def update
    @chatrooms = Chatroom.all
    @chatroom.update_attributes chatroom_params
    # if @chatroom.update_attributes chatroom_params
    #   flash.now[:success] = "Update chatroom success!"
    # else
    #   flash.now[:alert] = "Oops!!! Update chatroom failed"
    # end
    @chatroom = Chatroom.new
  end

  def destroy
    if @chatroom.destroy
      flash[:success] = "Delete chatroom success!"
    else
      flash[:alert] = "Oops!!! Delete chatroom failed"
    end
    redirect_to admin_chatrooms_url
  end

  private

  def chatroom_params
    params.require(:chatroom).permit :name, :chatroom_id
  end

  def load_chatroom
    @chatroom = Chatroom.find_by id: params[:id]
    return if @chatroom
    flash[:alert] = "Oops!!! Cannot find chatroom"
    redirect_to admin_chatrooms_url
  end
end
