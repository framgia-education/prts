class Admin::ProjectsController < ApplicationController
  def index
    @projects = Project.page(params[:page]).per 10
  end

  def create
    @project = Project.new project_params

    if @project.save
      flash[:success] = "Create success"
    else
      flash[:notice] = "Create failed"
    end
    redirect_to projects_path
  end

  private

  def project_params
    params.required(:project).permit! :name
  end
end
