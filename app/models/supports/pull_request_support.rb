module Supports
  class PullRequestSupport
    def initialize user = nil
      @user = user
    end

    def total_pull_requests
      PullRequest.with_user(@user).count
    end

    def ready_pulls_size
      PullRequest.ready.with_user(@user).size
    end

    def reviewing_pulls_size
      PullRequest.reviewing.with_user(@user).size
    end

    def commented_pulls_size
      PullRequest.commented.with_user(@user).size
    end

    def conflicted_pulls_size
      PullRequest.conflicted.with_user(@user).size
    end

    def merged_pulls_size
      PullRequest.merged.with_user(@user).size
    end

    def closed_pulls_size
      PullRequest.closed.with_user(@user).size
    end
  end
end
