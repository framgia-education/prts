class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    redirect_to root_url if logged_in?
  end

  def create
    @user = User.find_by email: params[:session][:email].downcase
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
      flash[:success] = "Welcome back!"
      # redirect_back_or @user
      if @user.is_admin
        redirect_back_or admin_root_url
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
    redirect_to root_url
  end
end
