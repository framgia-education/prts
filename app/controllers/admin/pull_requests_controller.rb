class Admin::PullRequestsController < ApplicationController
  before_action :verify_trainer!
  before_action :load_pull, only: :update

  def index
    @support = Supports::PullRequestSupport.new
    @pull_requests = PullRequest.order(updated_at: :desc)
      .page params[:page]
  end

  def update
    respond_to do |format|
      if @pull_request.update pull_request_params
        format.json do
          render json: {
            status: @pull_request.status,
            url_files: @pull_request.url_files
          }, status: :ok
        end
      else
        format.json do
          render json: {
            error: @pull_request.errors.full_messages
          }, status: :unprocessable_entity
        end
      end
    end
  end

  private

  def pull_request_params
    params.require(:pull_request).permit :status
  end

  def load_pull
    @pull_request = PullRequest.find_by id: params[:id]
    return if @pull_request

    flash[:notice] = "Not found pull request with id #{params[:id]}"
    redirect_to admin_pull_requests_path
  end
end
