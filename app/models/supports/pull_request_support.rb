module Supports
  class PullRequestSupport
    def initialize office_id, user = nil
      @office_id = office_id
      @user = user
    end

    def total_pull_requests
      PullRequest.select_with_user_office(@user, @office_id).count
    end

    def ready_pulls_size
      PullRequest.ready.select_with_user_office(@user, @office_id).size
    end

    def reviewing_pulls_size
      PullRequest.reviewing.select_with_user_office(@user, @office_id).size
    end

    def commented_pulls_size
      PullRequest.commented.select_with_user_office(@user, @office_id).size
    end

    def conflicted_pulls_size
      PullRequest.conflicted.select_with_user_office(@user, @office_id).size
    end

    def merged_pulls_size
      PullRequest.merged.select_with_user_office(@user, @office_id).size
    end

    def closed_pulls_size
      PullRequest.closed.select_with_user_office(@user, @office_id).size
    end
  end
end
