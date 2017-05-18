class Admin::PullRequestsController < ApplicationController
  before_action :verify_admin!

  def index
    @pull_requests = PullRequest.includes(:user)
      .order(created_at: :desc)
      .page(params[:page]).per 10
  end

  def update
    @pull_request = PullRequest.find_by id: params[:id]

    if @pull_request.reviewing!
      flash[:success] = "Update successful"
    else
      flash[:notice] = "Update failed"
    end
    redirect_to request.referrer
  end
end
