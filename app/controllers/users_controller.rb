class UsersController < ApplicationController
  before_action :load_user

  def show
  end

  def edit
  end

  def update
    # if current_user.authenticate params[:user][:current_password]
    if current_user.update_attributes user_params
      flash[:success] = "Update successful"
      redirect_to root_url
    else
      flash[:notice] = "Update failed"
      redirect_to request.referrer
    end
    # else
    #   flash.now[:notice] = "Current password is not valid"
    #   render :edit
    # end
  end

  private

  def user_params
    params.require(:user).permit :chatwork_room_id, :chatwork_id,
      :password, :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]

    return if @user.present?
    flash[:danger] = "User is not exist!"
    redirect_to root_url
  end
end
