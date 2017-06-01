class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.integer :role, default: 0
      t.string :provider
      t.string :token
      t.string :refresh_token
      t.string :chatwork_id
      t.string :chatwork_room_id
      t.string :github_account

      t.timestamps
    end

    add_index :users, :github_account
  end
end
