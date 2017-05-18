class PullRequestsController < ApplicationController
  def index
    @pull_request = PullRequest.new
    @pull_requests = current_user.pull_requests
      .includes(:user).order created_at: :desc
    @projects = Project.all.map{|p| [p.name, p.id]}
  end

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

  def destroy
    @pull_request = PullRequest.find_by id: params[:id]

    if @pull_request.destroy
      flash[:success] = "Destroy successful"
    else
      flash[:notice] = "Destroy failed"
    end
    redirect_to request.referrer
  end

  private

  def pull_request_params
    params.require(:pull_request).permit :url
  end
end
