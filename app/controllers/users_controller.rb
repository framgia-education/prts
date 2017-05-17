class UsersController < ApplicationController
  before_action :logged_in_user, :load_user

  def show
  end

  def edit
  end

  def update
    if current_user.authenticate params[:user][:current_password]
      if current_user.update_attributes user_params
        flash[:success] = "Update password success"
        redirect_to root_url
      else
        flash[:danger] = "Update password failed"
        redirect_to request.referrer
      end
    else
      flash.now[:danger] = "Current password is not valid"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = "User is not exist!"
      redirect_to root_url
    end
  end
end
