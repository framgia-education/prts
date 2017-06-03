class UsersController < ApplicationController
  before_action :load_user, :verify_user!

  def show
  end

  def edit
  end

  def update
    if current_user.update_attributes user_params
      flash[:success] = "Update successful"
      redirect_to root_url
    else
      flash[:notice] = "Update failed"
      redirect_to request.referrer
    end
  end

  private

  def user_params
    params.require(:user).permit :chatwork_room_id, :chatwork_id,
      :github_account
  end

  def load_user
    @user = User.find_by id: params[:id]

    return if @user.present?
    flash[:danger] = "User is not exist!"
    redirect_to root_url
  end

  def verify_user!
    return if current_user? @user
    flash[:alert] = "Access denied!"
    redirect_to root_url
  end
end
