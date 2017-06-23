module Api
  module Extensions
    class FeedsController < Api::BaseController
      def show
        render json: {content: feeds_content}
      end

      private

      def feeds_content
        action_controller = ActionController::Base.new
        action_controller.render_to_string(
          partial: "/api/extensions/feeds/new_feeds",
          layout: false,
          locals: {feeds: PullRequest.all})
      end
    end
  end
end
