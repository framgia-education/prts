class Admin::UsersController < ApplicationController
  before_action :verify_admin!
  before_action :load_user, except: [:index, :new, :create]
  before_action :load_offices, except: [:index, :show, :destroy]

  def index
    @support = Supports::UserSupport.new
    @users = User.includes(:pull_requests).order(created_at: :desc).page params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:success] = "Create user successfully!"
      params[:create_and_continue].nil? ? redirect_to(admin_users_url) :
        redirect_to(new_admin_user_url)
    else
      render :new
    end
  end

  def show; end

  def edit
    params[:office_id] = @user.office_id
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = "Update user successfully!"
      redirect_to admin_users_url
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "Delete user successfully!"
    else
      flash[:alert] = "Oops!!! Delete user failed"
    end
    redirect_to admin_users_url
  end

  private

  def user_params
    params.require(:user).permit User::ATTR_PARAMS
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:alert] = "Oops!!! User not found"
    redirect_to admin_users_url
  end
end
