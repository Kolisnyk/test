# Orders action log
class OrdersBlog < ApplicationRecord
  def self.log(order, driv, disp, act)
    create(order_id: order, driver_id: driv, dispatcher_id: disp, action: act)
  end
end
