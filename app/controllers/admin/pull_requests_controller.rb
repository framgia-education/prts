class Admin::PullRequestsController < ApplicationController
  before_action :verify_trainer!

  def index
    @pull_requests = PullRequest.order(created_at: :desc)
      .page(params[:page]).per Settings.admin.pull_request.per_page
  end
end
