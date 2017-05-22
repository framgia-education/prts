class CreatePullRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :pull_requests do |t|
      t.string :url
      t.integer :status, default: 0
      t.string :repository_name
      t.string :github_account

      t.timestamps
    end

    add_index :pull_requests, :github_account
    add_index :pull_requests, :status
  end
end
