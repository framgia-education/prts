class PullRequest < ApplicationRecord
  paginates_per Settings.pull_request.per_page

  belongs_to :user, primary_key: :github_account,
    foreign_key: :github_account, optional: true

  validates :url, presence: true

  enum status: [:ready, :commented, :conflicted, :reviewing, :merged, :closed]

  # after_update :send_message_to_chatwork

  delegate :name, to: :user, prefix: true, allow_nil: true

  def url_files
    url + "/files"
  end

  scope :ready_status, ->{where(status: :ready).size}
  scope :reviewing_status, ->{where(status: :reviewing).size}
  scope :commented_status, ->{where(status: :commented).size}
  scope :conflicted_status, ->{where(status: :conflicted).size}
  scope :merged_status, ->{where(status: :merged).size}

  private

  def send_message_to_chatwork
    user = User.find_by github_account: github_account

    return if user.nil?
    return if user.chatwork_id.nil? || user.chatwork_room_id.nil?

    pull_index = url.split("/").last

    case status
    when "ready"
      mess = "Your pull request no. ##{pull_index} is ready. Good luck to you!\n#{url}/files"
    when "commented"
      mess = "Your pull request no. ##{pull_index} has been (commented)\n#{url}/files"
    when "conflicted"
      mess = "Your pull request no. ##{pull_index} is conflicted.\n#{url}"
    when "reviewing"
      mess = "Your pull request no. ##{pull_index} is under reviewing.\n#{url}/files"
    when "merged"
      mess = "Your pull request no. ##{pull_index} has been (merged)\n#{url}"
    end

    mess += "\n\n#{$remark}" if $remark
    $remark = nil
    ChatWork::Message.create room_id: user.chatwork_room_id,
      body: "[To:#{user.chatwork_id}] #{user.name}\n" + mess
    mess = nil
  end
end
