class RemoveColumnFromOrders < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :new, :boolean
    remove_column :orders, :accepted, :boolean
    remove_column :orders, :arrived, :boolean
    remove_column :orders, :declined, :boolean
    remove_column :orders, :waiting, :boolean
    remove_column :orders, :done, :boolean
    add_column :orders, :status, :string, default: 'incoming'
  end
end
