class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :phone
      t.string :start_point
      t.string :end_point
      t.text :comment
      t.integer :client_id
      t.integer :driver_id
      t.integer :dispatcher_id
      t.integer :passengers
      t.boolean :baggage

      t.timestamps
    end
  end
end
