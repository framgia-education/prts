class Admin::OfficesController < ApplicationController
  before_action :verify_trainer!, only: [:index, :show]
  before_action :verify_admin!, except: [:index, :show]
  before_action :load_office, except: [:index, :new, :create]

  def index
    @offices = Office.select(:id, :name, :address, :description).page params[:page]
    @support_user = Supports::UserSupport.new
  end

  def new
    @office = Office.new
  end

  def create
    @office = Office.new office_params

    if @office.save
      flash[:success] = "Create office successfully!"
      redirect_to admin_offices_url
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @office.update_attributes office_params
      flash[:success] = "Update office successfully!"
      redirect_to admin_offices_url
    else
      render :edit
    end
  end

  def destroy
    if @office.users.any?
      flash[:alert] = "Cannot delete office that has any members!"
    else
      if @office.destroy
        flash[:success] = "Delete office successfully!"
      else
        flash[:alert] = "Oops!!! Delete office failed"
      end
    end
    redirect_to admin_offices_url
  end

  private

  def office_params
    params.require(:office).permit Office::ATTR_PARAMS
  end

  def load_office
    @office = Office.find_by id: params[:id]
    return if @office
    flash[:alert] = "Oops!!! Office not found"
    redirect_to admin_offices_url
  end
end
