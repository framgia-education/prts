class Admin::UsersController < ApplicationController
  before_action :verify_trainer!, only: [:index, :show]
  before_action :verify_admin!, except: [:index, :show]
  before_action :load_user, except: [:index, :new, :create]
  before_action :load_offices, except: [:index, :show, :destroy]

  def index
    @support = Supports::UserSupport.new
    @users = User.includes(:pull_requests).search(params[:search])
      .order(created_at: :desc).page params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new create_user_params

    if @user.save
      flash[:success] = "Create user successfully!"
      params[:create_and_continue].nil? ? redirect_to(admin_users_url) :
        redirect_to(new_admin_user_url)
    else
      render :new
    end
  end

  def show
    respond_to do |format|
      format.html{render partial: "show_user", locals: {user: @user}}
    end
  end

  def edit
    respond_to do |format|
      format.html do
        render partial: "edit_user", locals: {user: @user, offices: @offices}
      end
    end
  end

  def update
    if @user.update_attributes update_user_params
      flash[:success] = "Update user successfully!"
    else
      flash[:alert] = "Oops!!! Update user failed"
    end

    redirect_to admin_users_url
  end

  def destroy
    if @user.pull_requests.any?
      flash[:alert]= "Cannot delete user having pull requests!"
    else
      if @user.role != "normal"
        flash[:alert] = "Cannot delete account who is not normal user"
      else
        if @user.destroy
          flash[:success] = "Delete user successfully!"
        else
          flash[:alert] = "Oops!!! Delete user failed"
        end
      end
    end
    redirect_to admin_users_url
  end

  private

  def create_user_params
    params.require(:user).permit User::CREATE_ATTR_PARAMS
  end

  def update_user_params
    params.require(:user).permit User::UPDATE_ATTR_PARAMS
  end

  def load_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:alert] = "Oops!!! User not found"
    redirect_to admin_users_url
  end
end
