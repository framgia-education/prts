class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, if: Proc.new {|c| c.request.format == "application/json"}
  include SessionsHelper

  before_action :authenticate_user!

  private

  def verify_admin!
    return if current_user.admin?
    flash[:alert] = "Oops!!! Access denied!"
    redirect_to root_url
  end

  def verify_trainer!
    return if current_user.admin? || current_user.trainer?
    flash[:alert] = "Oops!!! Access denied!"
    redirect_to root_url
  end

  def verify_supporter!
    return unless current_user.normal?
    flash[:alert] = "Oops!!! Access denied!"
    redirect_to root_url
  end

  def authenticate_user!
    return if current_user.present?
    store_location

    flash[:notice] = "You need to sign in before continuing"
    redirect_to login_url
  end

  def load_offices
    @offices = Office.all
  end

  def load_office_current_user
    return unless current_user.office
    params[:office_id] = current_user.office.id
  end
end
