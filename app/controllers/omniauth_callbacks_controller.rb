class OmniauthCallbacksController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    auth = request.env["omniauth.auth"]
    @user = User.from_omniauth auth

    if @user.persisted?
      log_in @user
      flash[:success] = "Sign in with TMS System successfully!"
    else
      flash[:notice] = "Oops!!! Auth failure"
    end

    if @user.admin? || @user.trainer?
      redirect_to admin_pull_requests_url
    else
      redirect_to root_path
    end
  end

  def show; end

  def failure
    flash[:notice] = "Auth failure"
    redirect_to root_path
  end
end
