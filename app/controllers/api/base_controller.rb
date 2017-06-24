module Api
  class BaseController < ActionController::API
    protected

    def verify_params
      return if oauth_token
      return render json: {status: 0}, status: 404
    end

    def oauth_token
      @oauth_token ||= request.headers["HTTP_OAUTH_TOKEN"]
    end

    def load_user
      @user = User.find_by oauth_token: oauth_token

      return if @user
      return render json: {status: 0}, status: 404
    end
  end
end
