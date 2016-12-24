class CreateOrdersBlogs < ActiveRecord::Migration[5.0]
  
  def change
    create_table :orders_blogs do |t|
      t.string :action

      t.integer :order_id     
      t.integer :dispatcher_id
	    t.integer :driver_id
      t.timestamps
    end
  end
  
end
