# Orders controller
class OrdersController < ApplicationController
  include WsBroadcast
  before_action :set_order, except: [:index, :create]
  respond_to :html, :json

  def index
  end

  def create
    @order = Order.new(order_params)
    dispatcher_presence
    respond_to do |format|
      @order.save ? create_success(format) : create_failure(format)
    end
  end

  def destroy
    @order.destroy
    render json: { status: :ok }
  end

  private

  def create_success(format)
    logging
    driver_assigned = @order.status == 'waiting' ? true : false
    assign_driver if driver_assigned
    broadcast('dispatcher', 'new_order', @order.as_json) unless driver_assigned

    OrderMailer.order_email(@order).deliver
    format.html { redirect_to root_path, notice: 'Order successfully created.' }
    format.json { render :show, status: :created, location: @order }
  end

  def create_failure(format)
    format.html { redirect_to '/', notice: @order.errors }
    format.json { render json: @order.errors, status: :unprocessable_entity }
  end

  def order_params
    filters = [:phone, :email, :start_point, :end_point,
               :comment, :passengers, :baggage]
    filters += [:driver_id, :status] if current_dispatcher
    params.require(:order).permit(filters)
  end

  def set_order
    @order = Order.find(params[:id])
    render json: { status: :not_found } unless @order
  end

  def dispatcher_presence
    return if current_dispatcher.nil?
    @order.dispatcher_id = current_dispatcher.id
  end

  def assign_driver
    return if params[:order][:status] != 'waiting'
    driver = Driver.find(params[:order][:driver_id])
    driver.update status: 'busy'
    ws_message('driver', driver.id, 'receive_order', @order.as_json)
    broadcast('dispatcher', 'remove_driver', driver.as_json)
  end

  def logging
    OrdersBlog.log(@order.id, nil, @order.dispatcher_id, 'Created')
    return if @order.driver_id.nil?
    message = 'Assigned'
    OrdersBlog.log(@order.id, @order.driver_id, @order.dispatcher_id, message)
  end
end
