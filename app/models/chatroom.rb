class Chatroom < ApplicationRecord
  validates :name, presence: true
  validates :chatroom_id, presence: true
end
