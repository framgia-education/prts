class HookService
  attr_accessor :repository, :comment, :sender, :commenter

  MESSAGES_VALID = ["ready", "commented", "conflicted", "reviewing", "merged", "closed"]

  def initialize payload
    @payload = JSON.parse(payload)
    @repository = @payload["repository"]
    @comment = @payload["comment"]
    @owner = @payload["issue"]["user"]
    @sender = @payload["sender"]
    @pull_request = @payload["issue"]["pull_request"]
    @comment_body = @comment["body"].downcase
  end

  def valid?
    return false unless MESSAGES_VALID.include?(@comment_body)
    if (@sender == @owner && (["ready", "closed"].include? @comment_body)) ||
      WhiteList.first.github_account.include?(@sender["login"])
      return true
    end
  end

  def make_tracking_pull_request
    pull = PullRequest.find_by url: @pull_request["html_url"]

    if pull.present?
      pull.update_attributes status: @comment_body
    else
      PullRequest.create url: @pull_request["html_url"],
        repository_name: @repository["name"],
        github_account: @owner["login"],
        status: "ready"
    end
  end
end
