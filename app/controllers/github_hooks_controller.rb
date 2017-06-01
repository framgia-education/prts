class GithubHooksController < ApplicationController
  skip_before_action :authenticate_user!, :verify_authenticity_token
  before_action :verify_token!

  def create
    hook_service = HookService.new request
    hook_service.make_tracking_pull_request if hook_service.valid?

    head :ok
  end

  private

  def verify_token!
    @token = params[:access_token]

    if @token.blank? || @token != Settings.access_token
      head :ok
      return
    end
  end
end
