class PullRequest < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :url, presence: true

  enum status: [:ready, :commented, :conflicted, :reviewing, :merged, :closed]

  after_update :send_message_to_chatwork

  private

  def send_message_to_chatwork
    ChatWork::Message.create room_id: user.chatwork_room_id,
      body: "[To:#{user.chatwork_id}] \n Your pullrequest (url) is #{status}"
  end
end
