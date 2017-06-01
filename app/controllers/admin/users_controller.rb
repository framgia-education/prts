class Admin::UsersController < ApplicationController
  before_action :verify_admin!
  before_action :load_user, except: [:index, :new, :create]

  def index
    @users = User.includes(:pull_requests).order(name: :asc)
      .page(params[:page]).per Settings.admin.user.per_page
  end

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new user_params

    if @user.save
      flash[:success] = "Create successfully!"
      params[:create_and_continue].nil? ? redirect_to(admin_users_url) : render(:new)
    else
      flash.now[:error] = "Create failed"
      render :new
    end
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = "Update successfully"
      redirect_to admin_users_url
    else
      flash.now[:danger] = "Update failed"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "Delete successfully"
    else
      flash[:error] = "Delete failed"
    end
    redirect_to admin_users_url
  end

  private

  def user_params
    params.require(:user).permit User::ATTR_PARAMS
  end

  def load_user
    @user = User.find_by id: params[:id]

    unless @user
      flash[:error] = "Not found user"
      redirect_to admin_users_url
    end
  end
end
