class CreateChatRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_rooms do |t|
      t.string :name
      t.string :chat_room_id

      t.timestamps
    end
  end
end
