# Drivers controller
class DriversController < ApplicationController
  include WsBroadcast
  before_action :authenticate_driver!, only: [:orders]
  before_action :set_order, except: [:orders]
  respond_to :html, :json

  def orders
    @driver = current_driver
    @orders = @driver.orders.where(status: %w(waiting arrived accepted))
    @orders = @driver.orders.where('updated_at >=? AND status =?',
                                   Date.yesterday, 'done') if @orders.blank?
    respond_with(@orders) do |format|
      format.json { render json: @orders.as_json }
      format.html
    end
  end

  def update_order
    @order_status = params[:order][:status]
    @event = @order.status == @order_status ? 'change_order' : 'new_order'
    @driver = Driver.find(params[:order][:driver_id]) unless
      params[:order][:driver_id].nil?
    dispatcher_presence
    driver_presence
    @order.update(order_params) ? update_success : update_failure
  end

  private

  def update_success
    logging
    mailers
    ws_update_messages
    render json: @order.as_json
  end

  def update_failure
    render json: @order.errors, status: :unprocessable_entity
  end

  def mailers
    OrderMailer.accept_order(@order).deliver if @order.status == 'accepted'
    OrderMailer.execute_order(@order).deliver if @order.status == 'done'
    OrderMailer.arrive(@order, @driver).deliver if @order.status == 'arrived'
  end

  def ws_update_messages
    if @order.status == 'incoming' || @order.status == 'declined'
      broadcast('dispatcher', @event, @order.as_json)
    elsif @order.status == 'waiting' || @order.status == 'canceled'
      broadcast('dispatcher', 'remove_order', @order.as_json)
    end
  end

  def order_params
    filters = [:status, :decline_order] if current_driver || current_dispatcher
    filters += [:phone, :email, :start_point, :end_point, :comment,
                :passengers, :baggage, :driver_id] if current_dispatcher
    params.require(:order).permit(filters)
  end

  def set_order
    @order = Order.find(params[:id])
    render json: { status: :not_found } unless @order
  end

  def driver_presence
    return if current_driver.nil?
    return if @order_status != 'declined' && @order_status != 'done'
    current_driver.update status: 'available'
    @order.driver_id = nil if @order_status == 'declined'
    broadcast('dispatcher', 'new_driver', current_driver.as_json)
  end

  def dispatcher_presence
    return if current_dispatcher.nil?
    @order.dispatcher_id = current_dispatcher.id
    assign_driver
  end

  def assign_driver
    return if @order_status != 'waiting'
    driver = Driver.find(params[:order][:driver_id])
    driver.update status: 'busy'
    @order.status = 'waiting'
    @order.driver_id = driver.id
    ws_message('driver', driver.id, 'receive_order', @order.as_json)
    broadcast('dispatcher', 'remove_driver', driver.as_json)
  end

  def logging
    state = @order.status.capitalize
    case state
    when 'Canceled'
      log(nil, current_dispatcher.id, state)
    when 'Done', 'Accepted', 'Arrived'
      log(current_driver.id, nil, state)
      (current_driver.update done: current_driver.done + 1) if state == 'Done'
    when 'Waiting'
      log(@order.driver_id, current_dispatcher.id, 'Assigned')
    when 'Declined', 'Incoming'
      if current_driver
        log(current_driver.id, nil, state)
        current_driver.update cancelled: current_driver.cancelled + 1
      else
        log(nil, current_dispatcher.id, 'Corrected')
      end
    end
  end

  def log(driver, dispatcher, action)
    OrdersBlog.log(@order.id, driver, dispatcher, action)
  end
end
