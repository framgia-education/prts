class AddReferencesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :office, foreign_key: true
  end
end
