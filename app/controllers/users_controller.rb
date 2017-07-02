class UsersController < ApplicationController
  before_action :load_user, :verify_user!
  before_action :load_offices, only: :edit

  def show; end

  def edit
    params[:office_id] = @user.office_id
  end

  def update
    if current_user.update_attributes user_params
      flash[:success] = "Update information success!"
    else
      flash[:alert] = "Oops!!! Update information failed"
    end
    redirect_to request.referrer
  end

  private

  def user_params
    params.require(:user).permit :chatwork_room_id, :chatwork_id,
      :github_account, :oauth_token, :office_id
  end

  def load_user
    @user = User.find_by id: params[:id]

    return if @user.present?
    flash[:error] = "Oops!!! User is not exist!"
    redirect_to root_url
  end

  def verify_user!
    return if current_user? @user
    flash[:alert] = "Oops!!! Access denied!"
    redirect_to root_url
  end
end
