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

  private

  def pull_request_params
    params.require(:pull_request).permit :url
  end
end
