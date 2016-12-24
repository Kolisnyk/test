# This class used for additional methods of Orders
class OrdersTask < OrdersController
  include WsBroadcast
  def time_check
    @orders = Order.where(status: 'waiting')
    return if @orders.nil?
    @orders.each do |order|
      next unless Time.now.utc - order.updated_at > 300
      driver = Driver.find(order.driver_id)
      driver_online = driver.status != 'offline' ? true : false
      (driver.update status: 'available') if driver_online
      order.update status: 'declined', driver_id: nil
      arbitrary_actions(driver, order, driver_online)
    end
  end

  def arbitrary_actions(driver, order, driver_online)
    log_message = 'Declined by timeout'
    OrdersBlog.log(order.id, driver.id, order.dispatcher_id, log_message)
    driver.update cancelled: driver.cancelled + 1
    history = driver.orders.where('updated_at >=? AND status =?',
                                   Date.yesterday, 'done')
    ws_message('driver', driver.id, 'order_timed_out', history.as_json)
    broadcast('dispatcher', 'new_driver', driver.as_json) if driver_online
    broadcast('dispatcher', 'new_order', order.as_json)
  end
end
