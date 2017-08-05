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
    respond_to do |format|
      format.html do
        render partial: "form_office",
          locals: {office: @office, modal_title: "New Office", button_text: "Create"}
      end
    end
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

  def show
    respond_to do |format|
      format.html{render partial: "show_office", locals: {office: @office}}
    end
  end

  def edit
    respond_to do |format|
      format.html do
        render partial: "form_office",
          locals: {office: @office, modal_title: "Edit Office", button_text: "Update"}
      end
    end
  end

  def update
    if @office.update_attributes office_params
      flash[:success] = "Update office successfully!"
    else
      flash[:alert] = "Oops!!! User office failed"
    end

    redirect_to admin_offices_url
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
