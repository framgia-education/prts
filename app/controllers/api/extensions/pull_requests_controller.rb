module Api
  module Extensions
    class PullRequestsController < Api::BaseController
      before_action :verify_params, only: :update
      before_action :load_user, :verify_user, only: :update
      before_action :load_pull, only: :update

      def update
        if @pull.reviewing!
          render json: {status: 1}, status: :ok
        else
          render json: {status: 0}, status: 404
        end
      end

      private

      def load_pull
        @pull = PullRequest.find_by id: params[:id]

        return if @pull
        return render json: {status: 0}, status: 404
      end

      def verify_user
        return if @user.trainer? || @user.admin?
        return render json: {status: 0}, status: 404
      end
    end
  end
end
