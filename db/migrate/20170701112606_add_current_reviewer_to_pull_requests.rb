class AddCurrentReviewerToPullRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :pull_requests, :current_reviewer, :string
  end
end
