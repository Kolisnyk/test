class OrderMailer < ApplicationMailer
	default from: "sloboda-taxi@gmail.com"

	def order_email(order)
		@order = order
		mail(to: @order.email, subject: 'Order Email')
	end	
end
