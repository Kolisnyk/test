# app/controllers/concerns/ws_broadcast.rb
module WsBroadcast
  extend ActiveSupport::Concern

  def ws_message(role, id, event, object)
    return unless WebsocketRails.users[role].users[id.to_s]
    WebsocketRails.users[role][id].send_message(event, object.as_json)
  end

  def broadcast(role, event, object)
    WebsocketRails.users[role].each do |user|
      user.send_message(event, object.as_json)
    end
  end
end
