class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :first_name
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.integer :stage, default: 0
      t.boolean :is_admin
      t.string :provider
      t.string :token
      t.string :refresh_token

      t.timestamps
    end
  end
end
