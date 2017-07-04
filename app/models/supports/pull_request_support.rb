module Supports
  class PullRequestSupport
    def initialize user = nil, office_id
      @user = user
      @office_id = office_id
    end

    def total_pull_requests
      PullRequest.with_user(@user).of_office(@office_id).count
    end

    def ready_pulls_size
      PullRequest.ready.with_user(@user).of_office(@office_id).size
    end

    def reviewing_pulls_size
      PullRequest.reviewing.with_user(@user).of_office(@office_id).size
    end

    def commented_pulls_size
      PullRequest.commented.with_user(@user).of_office(@office_id).size
    end

    def conflicted_pulls_size
      PullRequest.conflicted.with_user(@user).of_office(@office_id).size
    end

    def merged_pulls_size
      PullRequest.merged.with_user(@user).of_office(@office_id).size
    end

    def closed_pulls_size
      PullRequest.closed.with_user(@user).of_office(@office_id).size
    end
  end
end
