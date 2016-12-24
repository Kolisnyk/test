class AddActiveToDispatchers < ActiveRecord::Migration[5.0]
  def change
    add_column :dispatchers, :active, :boolean
  end
end
