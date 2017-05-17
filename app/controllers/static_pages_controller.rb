class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @pull_request = PullRequest.new
      @pull_requests = current_user.pull_requests.includes(:user).order created_at: :desc
    else
      redirect_to login_url
    end
  end
end
