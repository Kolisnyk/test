# Manage relations between models
class WsCoreController < WebsocketRails::BaseController
  def initialize_session
    # perform application setup here
    controller_store[:message_count] = 0
  end

  def refresh
    clear_group('admin')
    clear_group('driver')
    clear_group('dispatcher')
    message = { 'message' => 'ping' }
    (broadcast_message :ping, message) if Driver.all.update status: 'offline'
  end

  private

  def clear_group(role)
    WebsocketRails.users[role].users.clear
  end
end
