require 'rufus-scheduler'
require_relative '../../lib/tasks/orders_task'

scheduler = Rufus::Scheduler.new
order = OrdersTask.new
scheduler.every '10s' do
  order.time_check
end
