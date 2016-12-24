class AddDeclineOrderToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :decline_order, :string
  end
end
