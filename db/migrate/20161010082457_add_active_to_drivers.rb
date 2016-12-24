class AddActiveToDrivers < ActiveRecord::Migration[5.0]
  def change
    add_column :drivers, :active, :boolean
  end
end
