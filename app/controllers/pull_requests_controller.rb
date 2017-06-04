class PullRequestsController < ApplicationController
  def index
    @pull_requests_size = current_user.pull_requests.count
    @pull_requests = current_user.pull_requests.order(created_at: :desc)
      .page(params[:page]).per Settings.pull_request.per_page
  end

  def destroy
    @pull_request = PullRequest.find_by id: params[:id]

    if @pull_request.destroy
      flash[:success] = "Destroy successful"
    else
      flash[:notice] = "Destroy failed"
    end
    redirect_to request.referrer
  end
end
