class AddDefaultsToDrivers < ActiveRecord::Migration[5.0]
  def change
    change_column :drivers, :passengers, :integer, default: 0
    change_column :drivers, :trunk, :integer, default: 0
  end
end
