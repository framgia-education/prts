class Admin::UsersController < ApplicationController
  before_action :logged_in_user, :verify_admin
  before_action :load_user, only: [:edit, :update]

  def index
    @users = User.includes(:pull_requests).order(first_name: :asc)
      .page(params[:page]).per 50
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = "Create user success!"
      if params[:create_and_continue]
        redirect_to new_admin_user_url
      else
        redirect_to admin_users_url
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    if params[:start_project]
      @user.stage = 1
      if @user.save
        flash[:success] = "#{@user.full_name} started project 1 !"
      else
        flash[:danger] = "Cannot change user's status"
      end
      redirect_to request.referrer
    else
      if @user.update_attributes user_params
        flash[:success] = "Update user success !"
        redirect_to admin_users_url
      else
        flash.now[:danger] = "Update user failed !"
        render :new
      end
    end
  end

  private

  def user_params
    params.require(:user).permit :full_name, :first_name, :email,
      :password, :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = "User not found"
      redirect_to request.referrer
    end
  end
end
