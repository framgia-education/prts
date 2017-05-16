class UsersController < ApplicationController
  def show
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = "User is not exist!"
      redirect_to root_url
    end
  end
end
