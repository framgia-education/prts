class PullRequestsController < ApplicationController
  def create
    @pull_request = PullRequest.new pull_request_params
    @pull_request.user_id = current_user.id
    if @pull_request.save
      flash[:success] = "Submit new pull request success!"
    else
      flash[:danger] = "Opp!!! Submit new pull request failed!"
    end
    redirect_to root_url
  end

  def update
    @pull_request = PullRequest.find_by id: params[:id]
    status = params[:status]
    case status
    when "merge"
      @pull_request.status = "merged"
    when "close"
      @pull_request.status = "closed"
    when "ready"
      @pull_request.status = "ready"
    end
    @pull_request.save
    redirect_to root_url
  end

  private

  def pull_request_params
    params.require(:pull_request).permit :url
  end
end
