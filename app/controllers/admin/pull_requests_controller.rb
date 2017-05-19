class Admin::PullRequestsController < ApplicationController
  before_action :verify_admin!

  def index
    @pull_requests = PullRequest.order(created_at: :desc)
      .page(params[:page]).per 10
  end
end
