class PullRequest < ApplicationRecord
  belongs_to :user

  validates :url, presence: true
  enum status: [:ready, :commented, :conflicted, :reviewing, :merged, :closed]
end
