class AddDefaultToDriversStatus < ActiveRecord::Migration[5.0]
  def change
    change_column :drivers, :status, :string, default: 'offline'
  end
end
