class PullRequestsController < ApplicationController
  def index
    load_office_current_user unless params[:office_id]
    @support = Supports::PullRequestSupport.new current_user, params[:office_id]
    @support_user = Supports::UserSupport.new
    @pull_requests = current_user.pull_requests.order(updated_at: :desc)
      .page params[:page]
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
