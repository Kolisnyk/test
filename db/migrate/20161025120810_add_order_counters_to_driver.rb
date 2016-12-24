class AddOrderCountersToDriver < ActiveRecord::Migration[5.0]
  def change
    add_column :drivers, :done, :integer, default: 0
    add_column :drivers, :cancelled, :integer, default: 0
  end
end
