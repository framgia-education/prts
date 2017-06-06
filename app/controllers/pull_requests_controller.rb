class PullRequestsController < ApplicationController
  def index
    @support = Supports::PullRequestSupport.new
    @support_user = Supports::UserSupport.new
    @pull_requests = current_user.pull_requests.order(updated_at: :desc)
      .page(params[:page])
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
