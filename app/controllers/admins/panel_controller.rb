class Admins::PanelController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :check_admin
  before_action :authenticate_admin!
  layout false

  def index
    @admins = Admin.order('active DESC').all
    @dispatchers = Dispatcher.order('active DESC').all
    @drivers = Driver.order('active DESC').all
  end

  # Render form for adding new avatar
  def edit_driver_photo
    @driver = Driver.find_for_authentication(id: params[:id])
  end

  # Updates database
  def update_driver_photo
    @driver = Driver.find_for_authentication(id: params[:id])
    if params[:submit] == 'Save'
      @driver.avatar = params[:avatar] unless params[:avatar].nil?
    elsif params[:submit] == 'Delete'
      @driver.avatar = nil
    end
    @driver.save
  end

  def action_log
    @orders_blogs = OrdersBlog.order('updated_at DESC')
    filter_by_order
    filter_by_action
    filter_by_driver
    filter_by_dispatcher
    filter_by_time_from
    filter_by_time_to
    @orders_blogs = @orders_blogs.page(params[:page]).per(20)
  end

  private

  def filter_by_order
    return if params[:order].nil?
    order_filter = params[:order].strip
    return if order_filter.empty?
    order_id = []
    if order_filter.length == 10
      orders = Order.where(phone: order_filter)
      orders.each do |order|
        order_id.push(order.id)
      end
    else
      order_id.push(order_filter)
    end
    @orders_blogs = @orders_blogs.where(order_id: order_id)
  end

  def filter_by_action
    return if params[:action_field].nil?
    action_filter = params[:action_field].strip.capitalize
    return if action_filter.empty?
    @orders_blogs = @orders_blogs.where(action: action_filter)
  end

  def filter_by_driver
    return if params[:driver].nil?
    driver_filter = params[:driver].strip
    return if driver_filter.empty?
    driver_id = []
    if driver_filter.length == 10
      drivers = Driver.where(phone: driver_filter)
      drivers.each do |driver|
        driver_id.push(driver.id)
      end
    else
      driver_id.push(driver_filter)
    end
    @orders_blogs = @orders_blogs.where(driver_id: driver_id)
  end

  def filter_by_dispatcher
    return if params[:dispatcher].nil?
    disp_filter = params[:dispatcher].strip
    return if disp_filter.empty?
    disp_id = []
    if disp_filter.include? '@'
      disps = Dispatcher.where(email: disp_filter)
      disps.each do |disp|
        disp_id.push(disp.id)
      end
    else
      disp_id.push(disp_filter)
    end
    @orders_blogs = @orders_blogs.where(dispatcher_id: disp_id)
  end

  def filter_by_time_from
    return if params[:from].nil?
    begin
      from_filter = DateTime.parse(params[:from].strip)
    rescue
      return
    end
    @orders_blogs = @orders_blogs.where('updated_at >=?', from_filter)
  end

  def filter_by_time_to
    return if params[:to].nil?
    begin
      to_filter = DateTime.parse(params[:to].strip)
    rescue
      return
    end
    @orders_blogs = @orders_blogs.where('updated_at <=?', to_filter)
  end

  def check_admin
    if current_admin.nil?
      redirect_to '/admin'
    end
  end
end
