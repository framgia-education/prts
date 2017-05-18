class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :authenticate_user!

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def verify_admin
    unless current_user.is_admin?
      flash[:danger] = "Access denied!"
      redirect_to root_url
    end
  end

  def authenticate_user!
    return if current_user.present?
    flash[:notice] = "You need to sign in before continuing"
    redirect_to login_url
  end
end
