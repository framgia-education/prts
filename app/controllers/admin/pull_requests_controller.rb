class Admin::PullRequestsController < ApplicationController
  def index
    @pull_requests = PullRequest.includes(:user).order(created_at: :desc).page(params[:page]).per 10
  end

  def update
    @pull_request = PullRequest.find_by id: params[:id]
    status = params[:status]
    case status
    when "reviewing"
      @pull_request.status = "reviewing"
    when "commented"
      @pull_request.status = "commented"
    when "merged"
      @pull_request.status = "merged"
    when "replied"
      @pull_request.status = "replied"
    when "conflict"
      @pull_request.status = "conflict"
    end
    @pull_request.reviewer = current_user.name
    @pull_request.save
    redirect_to request.referrer
  end
end
