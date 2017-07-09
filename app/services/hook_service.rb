class HookService
  attr_reader :repository, :comment, :sender, :commenter, :action

  MESSAGES_VALID = ["ready", "commented", "conflicted", "reviewing", "merged", "closed"]

  def initialize request
    @payload = JSON.parse(request.body.read)
    @action = @payload["action"]

    Rails.logger.info "---------------------------> #{@action}"
    if @action == "closed" && @payload["pull_request"]["merged"]
      @merged_pull = true
      @pull_request = @payload["pull_request"]
    elsif @action == "created"
      @repository = @payload["repository"]
      @comment = @payload["comment"]
      @owner = @payload["issue"]["user"]
      @sender = @payload["sender"]
      @pull_request = @payload["issue"]["pull_request"]
      @comment_body = @comment["body"]
    end
  end

  def valid?
    return false if ["assigned", "unassigned", "review_requested",
      "review_request_removed", "labeled", "unlabeled", "opened", "edited",
      "reopened", "submitted", "deleted", "synchronize", "dismissed"].include?(@action)

    return true if @merged_pull

    if @comment_body && @comment_body.include?("-")
      $bracket = @comment_body.split("-").third
      $remark = @comment_body.split("-").second
      $remark = "(" + $remark + ")" unless $bracket == "no"
      @comment_body = @comment_body.split("-").first.downcase
    end

    return false unless MESSAGES_VALID.include?(@comment_body)

    if (@sender == @owner && (["ready", "closed"].include? @comment_body)) ||
      WhiteList.first.github_account.include?(@sender["login"])
      return true
    end
  end

  def make_tracking_pull_request
    pull = PullRequest.find_by url: @pull_request["html_url"]

    if @merged_pull
      return if pull.status == "merged"
      pull.update_attributes status: :merged, current_reviewer: nil
      ActionCable.server.broadcast "room_channel_#{ENV["ACTION_CABLE_SECRET"]}", {status: pull.status, id: pull.id}
      return
    end

    if pull.present?
      return if pull.merged?
      return if @comment_body.downcase == pull.status
      return if (["ready", "reviewing"].include? pull.status) && @comment_body.downcase == "ready"
      return if (["commented", "conflicted"].include? pull.status) &&
        (["reviewing", "merged"].include? @comment_body.downcase)
      return if !pull.reviewing? && @comment_body.downcase == "conflicted"
      return if pull.conflicted? && @comment_body.downcase == "commented"
      pull.update_attributes status: @comment_body.downcase, current_reviewer: nil
      ActionCable.server.broadcast "room_channel_#{ENV["ACTION_CABLE_SECRET"]}", {status: pull.status, id: pull.id}
    else
      pull = PullRequest.create url: @pull_request["html_url"],
        repository_name: @repository["name"],
        github_account: @owner["login"],
        status: "ready"
    end

    if @payload["pull_request"] && @payload["pull_request"]["commits"] > 1
      message = "Your pull request #{pull.url} has one more commits (tat)!!!"
      ChatWork::Message.create room_id: pull.user.chatwork_room_id,
        body: "[To:#{pull.user.chatwork_id}] #{pull.user.name}\n" + message
    end
  end
end
