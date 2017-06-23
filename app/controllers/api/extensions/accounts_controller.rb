module Api
  module Extensions
    class AccountsController < Api::BaseController
      before_action :verify_params, only: :show

      def show
        user = User.find_by oauth_token: oauth_token

        if user
          render json: {user: user, status: 1}, status: :ok
        else
          render json: {status: 0}, status: 404
        end
      end

      private

      def verify_params
        return if oauth_token
        return render json: {status: 0}, status: 404
      end

      def oauth_token
        @oauth_token ||= request.headers["HTTP_OAUTH_TOKEN"]
      end
    end
  end
end
