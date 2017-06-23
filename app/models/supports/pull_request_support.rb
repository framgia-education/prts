class Supports::PullRequestSupport
  def total_pull_requests
    PullRequest.count
  end

  def ready_status
    PullRequest.ready_status
  end

  def reviewing_status
    PullRequest.reviewing_status
  end

  def commented_status
    PullRequest.commented_status
  end

  def conflicted_status
    PullRequest.conflicted_status
  end

  def merged_status
    PullRequest.merged_status
  end

  def closed_status
    PullRequest.closed.size
  end
end
