class PullRequest < ApplicationRecord
  belongs_to :user

  validates :url, presence: true
  enum status: [:open, :reviewing, :commented, :replied, :merged, :closed, :reopen, :conflict]
end
