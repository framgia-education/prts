class PullRequest < ApplicationRecord
  paginates_per Settings.pull_request.per_page

  belongs_to :user, primary_key: :github_account,
    foreign_key: :github_account, optional: true

  validates :url, presence: true

  enum status: [:ready, :commented, :conflicted, :reviewing, :merged, :closed]

  after_update :send_message_to_chatwork

  delegate :name, :github_account, to: :user, prefix: true, allow_nil: true

  def url_files
    url + "/files"
  end

  scope :in_current_month, -> do
    where "updated_at > ? AND updated_at < ?",
      Time.now.beginning_of_month, Time.now.end_of_month
  end

  scope :by_statuses, -> statuses{where status: statuses}

  scope :of_office, -> office_id do
    joins(:user).where("office_id = ?", office_id) if office_id.present?
  end

  scope :with_user, -> user{where user: user if user}

  scope :with_url, lambda{|url|
    where "url LIKE ?", "%#{url}%" if url.present?
  }

  scope :of_repository, lambda{|repository|
    where "repository_name = '#{repository}'" if repository.present?
  }

  scope :of_github_account, lambda{|github_account|
    where "pull_requests.github_account = '#{github_account}'" if github_account.present?
  }

  scope :select_with_multi_conditions, -> office_id, user, url, repository, github_account do
    of_office(office_id).with_user(user).with_url(url)
      .of_repository(repository).of_github_account(github_account)
  end

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
    when "closed"
      mess = "Your pull request no. ##{pull_index} has been closed (devil)\n#{url}"
    end

    mess += "\n\n#{$remark}" if $remark
    $remark = nil
    ChatWork::Message.create room_id: user.chatwork_room_id,
      body: "[To:#{user.chatwork_id}] #{user.name}\n" + mess
    mess = nil
  end
end
