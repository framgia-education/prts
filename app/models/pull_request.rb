class PullRequest < ApplicationRecord
  belongs_to :user

  validates :url, presence: true
  enum status: [:open, :reviewing, :commented, :merged, :closed, :reopen]
end
