class OrderMailer < ApplicationMailer
  default from: "sloboda-taxi@gmail.com"

  def order_email(order)
    @order = order
    mail(to: @order.email, subject: 'New Order')
  end

  def accept_order(order)
    @order = order
    mail(to: @order.email, subject: 'Accepted Order')
  end

  def execute_order(order)
    @order = order
    mail(to: @order.email, subject: 'Executed Order')
  end

  def arrive(order, driver)
    @order = order
    @driver = driver
    mail(to: @order.email, subject: 'Arrived Driver')
  end
end
