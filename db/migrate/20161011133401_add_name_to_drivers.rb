class AddNameToDrivers < ActiveRecord::Migration[5.0]
  def change
    add_column :drivers, :name, :string
  end
end
