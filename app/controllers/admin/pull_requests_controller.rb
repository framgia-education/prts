class Admin::PullRequestsController < ApplicationController
  before_action :verify_trainer!, :verify_admin!
  before_action :load_pull_request, only: :destroy

  def index
    @pull_requests_size = PullRequest.count
    @pull_requests = PullRequest.order(created_at: :desc)
      .page(params[:page]).per Settings.admin.pull_request.per_page
  end

  def destroy
    if @pull_request.destroy
      flash[:success] = "Delete pull request successfully!"
    else
      flash[:error] = "Delete pull request failed!"
    end
    redirect_to admin_pull_requests_url
  end

  private

  def load_pull_request
    @pull_request = PullRequest.find_by id: params[:id]

    unless @pull_request
      flash[:error] = "Not found pull request"
      redirect_to admin_pull_requests_url
    end
  end
end
