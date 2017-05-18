class Admin::UsersController < ApplicationController
  before_action :verify_admin!

  def index
    @users = User.includes(:pull_requests).order(first_name: :asc)
      .page(params[:page]).per 50
  end
end
