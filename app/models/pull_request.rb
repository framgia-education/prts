class PullRequest < ApplicationRecord
  validates :url, presence: true

  enum status: [:ready, :commented, :conflicted, :reviewing, :merged, :closed]

  after_update :send_message_to_chatwork

  private

  def send_message_to_chatwork
    user = User.find_by github_account: github_account
    return if user.nil?
    return if user.chatwork_id.nil? || user.chatwork_room_id.nil?

    ChatWork::Message.create room_id: 76035390,
      body: "[To:#{user.chatwork_id}] #{user.full_name} \n Your pull request #{url} is #{status}. \n (chucmung)"
  end
end
