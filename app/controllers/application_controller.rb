class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :authenticate_user!

  private

  def verify_admin!
    return if current_user.admin?
    flash[:alert] = "Access denied!"
    redirect_to root_url
  end

  def verify_trainer!
    return if current_user.admin? || current_user.trainer?
    flash[:alert] = "Access denied!"
    redirect_to root_url
  end

  def authenticate_user!
    return if current_user.present?
    store_location

    flash[:notice] = "You need to sign in before continuing"
    redirect_to login_url
  end
end
