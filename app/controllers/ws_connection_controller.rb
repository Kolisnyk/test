# Manage the connections
class WsConnectionController < WebsocketRails::BaseController
  def initialize_session
  end

  def client_connected
    handle(current_admin, 'admin', true) if current_admin
    handle(current_driver, 'driver', true) if current_driver
    handle(current_dispatcher, 'dispatcher', true) if current_dispatcher
  end

  def delete_user
    handle(current_admin, 'admin', false) if current_admin
    handle(current_driver, 'driver', false) if current_driver
    handle(current_dispatcher, 'dispatcher', false) if current_dispatcher
  end

  private

  def handle(user, role, state)
    manager = WebsocketRails.users[role]
    state ? add_connection(manager, user) : delete_connection(manager, user.id)
    arbitrary_actions(user, role, state)
  end

  def add_connection(manager, user)
    manager[user.id] = connection
  end

  def delete_connection(manager, user_id)
    return unless manager.users[user_id.to_s]
    manager[user_id].connections.delete(connection)
    manager.users.delete(user_id.to_s) if manager[user_id].connections.empty?
  end

  def arbitrary_actions(user, role, state)
    broadcast_message :ws_connection, 'id' => user.id, 'role' => role,
                                      'state' => state
    update_driver_status(user.id, state) if role == 'driver'
    update_admin_list if role == 'admin' && state == true
  end

  def update_driver_status(id, state)
    driver = Driver.find(id)
    if state
      orders_present = Order.on_driver.where(driver_id: id).present?
      driver.update status: orders_present ? 'busy' : 'available'
    else
      driver.update status: 'offline'
    end
    action = driver.status == 'available' ? :new_driver : :remove_driver
    broadcast_message action, driver.as_json
  end

  def update_admin_list
    update_users('admin')
    update_users('driver')
    update_users('dispatcher')
  end

  def update_users(role)
    WebsocketRails.users[role].users.each do |user|
      send_message :ws_connection, 'id' => user[0], 'role' => role,
                                   'state' => true
    end
  end
end
