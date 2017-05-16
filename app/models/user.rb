class User < ApplicationRecord
  has_many :pull_requests

  validates :name, presence: true
  enum stage: [:tutorial, :first_project]
end
