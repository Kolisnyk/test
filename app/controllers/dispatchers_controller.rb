# Dispatchers controller
class DispatchersController < ApplicationController
  before_action :authenticate_dispatcher!
  respond_to :html, :json

  def profile
  end

  def orders
    @orders = Order.where(status: %w(incoming declined))
    respond_with(@orders) do |format|
      format.json { render json: @orders.as_json }
      format.html
    end
  end

  def drivers
    @drivers = Driver.where(status: 'available')
    respond_with(@drivers) do |format|
      format.json { render json: @drivers.as_json }
      format.html
    end
  end
end
