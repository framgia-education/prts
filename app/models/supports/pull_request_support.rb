module Supports
  class PullRequestSupport
    def initialize office_id, user = nil, url = nil, repository = nil, github_account = nil
      @office_id = office_id
      @user = user
      @url = url
      @repository = repository
      @github_account = github_account
    end

    def total_pull_requests
      PullRequest.select_with_multi_conditions(@office_id, @user, @url, @repository, @github_account).count
    end

    def ready_pulls_size
      PullRequest.ready
        .select_with_multi_conditions(@office_id, @user, @url, @repository, @github_account).size
    end

    def reviewing_pulls_size
      PullRequest.reviewing
        .select_with_multi_conditions(@office_id, @user, @url, @repository, @github_account).size
    end

    def commented_pulls_size
      PullRequest.commented
        .select_with_multi_conditions(@office_id, @user, @url, @repository, @github_account).size
    end

    def conflicted_pulls_size
      PullRequest.conflicted
        .select_with_multi_conditions(@office_id, @user, @url, @repository, @github_account).size
    end

    def merged_pulls_size
      PullRequest.merged
        .select_with_multi_conditions(@office_id, @user, @url, @repository, @github_account).size
    end

    def closed_pulls_size
      PullRequest.closed
        .select_with_multi_conditions(@office_id, @user, @url, @repository, @github_account).size
    end

    def repositories
      PullRequest.distinct.select :repository_name
    end
  end
end
