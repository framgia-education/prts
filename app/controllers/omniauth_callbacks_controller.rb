class OmniauthCallbacksController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    auth = request.env["omniauth.auth"]
    @user = User.from_omniauth auth

    if @user.persisted?
      log_in @user
      flash[:success] = "Sign in with #{auth.provider.upcase} successfully!"
    else
      flash[:notice] = "Oops!!! Auth failure"
    end
    redirect_to root_path
  end

  def show; end

  def failure
    flash[:notice] = "Auth failure"
    redirect_to root_path
  end
end
