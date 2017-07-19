class AddNumberOfCommentsToPullRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :pull_requests, :number_of_comments, :integer
  end
end
