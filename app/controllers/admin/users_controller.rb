class Admin::UsersController < ApplicationController
  before_action :verify_admin!

  def index
    @users = User.includes(:pull_requests).order(name: :asc)
      .page(params[:page]).per 50
  end

  def new
    @user = User.new
  end
end
