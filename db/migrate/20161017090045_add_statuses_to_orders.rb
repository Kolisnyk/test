class AddStatusesToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :new, :boolean
    add_column :orders, :accepted, :boolean
    add_column :orders, :arrived, :boolean
    add_column :orders, :declined, :boolean
    add_column :orders, :waiting, :boolean
    add_column :orders, :done, :boolean
  end
end
