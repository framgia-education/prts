class UsersController < ApplicationController
  before_action :load_user, :verify_user!
  before_action :load_offices, only: :edit

  def show
    respond_to do |format|
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if params[:user][:oauth_token].present?
      respond_to do |format|
        if current_user.update_attributes user_params
          format.json do
            render json: {
              oauth_token: current_user.oauth_token
            }, status: :ok
          end
        else
          format.json do
            render json: {
              error: current_user.errors.full_messages
            }, status: :unprocessable_entity
          end
        end
      end
    else
      if current_user.update_attributes user_params
        flash[:success] = "Update information success!"
      else
        flash[:alert] = "Oops!!! Update information failed"
      end

      redirect_to request.referrer
    end
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
