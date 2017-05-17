class StaticPagesController < ApplicationController
  def home
    redirect_to login_url unless logged_in?
    @pull_request = PullRequest.new
    @pull_requests = current_user.pull_requests
  end
end
