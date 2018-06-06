class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    # redirect_to root_url
    redirect_to root_url if logged_in?
  end

  def create
    @user = User.find_by email: params[:session][:email].downcase

    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
      flash[:success] = "Welcome back!"

      if @user.admin? || @user.trainer?
        redirect_to admin_pull_requests_url
      else
        redirect_back_or root_url
      end
    else
      flash.now[:danger] = "Invalid email/password combination"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "Logout success"
    redirect_to root_url
  end
end
