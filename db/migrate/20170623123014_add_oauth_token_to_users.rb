class AddOauthTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :oauth_token, :string
    add_index :users, :oauth_token, unique: true
  end
end
