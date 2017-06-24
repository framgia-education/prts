module Api
  module Extensions
    class AccountsController < Api::BaseController
      before_action :verify_params, only: :show
      before_action :load_user, only: :show

      def show
        if @user
          render json: {user: @user, status: 1}, status: :ok
        else
          render json: {status: 0}, status: 404
        end
      end
    end
  end
end
