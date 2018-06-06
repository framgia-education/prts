class CreateWhiteLists < ActiveRecord::Migration[5.0]
  def change
    create_table :white_lists do |t|
      t.text :github_account

      t.timestamps
    end
  end
end
