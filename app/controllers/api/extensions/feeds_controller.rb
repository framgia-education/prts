module Api
  module Extensions
    class FeedsController < Api::BaseController
      before_action :verify_params, :load_user

      def show
        render json: {content: feeds_content}
      end

      private

      def feeds_content
        action_controller = ActionController::Base.new
        action_controller.render_to_string(
          partial: "/api/extensions/feeds/new_feeds",
          layout: false,
          locals: {
            feeds: PullRequest.send(params[:status]).of_office(@user.office_id)
                              .order(updated_at: :asc).limit(limit)
          }
        )
      end

      def limit
        params[:status] == "ready" ? 1 : 3
      end
    end
  end
end
