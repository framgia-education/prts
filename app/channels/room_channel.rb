class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{ENV["ACTION_CABLE_SECRET"]}"
  end

  def unsubscribed
  end

  def speak data
    ActionCable.server.broadcast "room_channel_#{ENV["ACTION_CABLE_SECRET"]}", data
  end
end
