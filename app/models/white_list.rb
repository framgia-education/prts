class WhiteList < ApplicationRecord
  validates :github_account, presence: true
end
