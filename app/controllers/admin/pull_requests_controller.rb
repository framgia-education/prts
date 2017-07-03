class Admin::PullRequestsController < ApplicationController
  before_action :verify_trainer!
  before_action :load_pull, only: :update
  before_action :load_offices, only: :index

  def index
    load_office_current_user unless params[:office_id]
    @support = Supports::PullRequestSupport.new params[:office_id]
    @support_user = Supports::UserSupport.new
    @pull_requests = PullRequest.order(updated_at: :desc).of_office(params[:office_id]).page params[:page]
  end

  def update
    respond_to do |format|
      @pull_request.current_reviewer = current_user.name
      if @pull_request.update pull_request_params
        ActionCable.server.broadcast "room_channel_#{ENV["ACTION_CABLE_SECRET"]}", {status: @pull_request.status, id: @pull_request.id}
        format.json do
          render json: {
            status: @pull_request.status,
            url_files: @pull_request.url_files,
            current_reviewer: @pull_request.current_reviewer
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
