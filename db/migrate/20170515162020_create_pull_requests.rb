class CreatePullRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :pull_requests do |t|
      t.string :url
      t.integer :status, default: 0
      t.references :user, foreign_key: true
      t.integer :reviewer_id

      t.timestamps
    end
  end
end
