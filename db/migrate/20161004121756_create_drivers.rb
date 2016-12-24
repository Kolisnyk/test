class CreateDrivers < ActiveRecord::Migration[5.0]
  def change
    create_table :drivers do |t|
      t.string :car_type
      t.integer :passengers
      t.integer :trunk

      t.timestamps
    end
  end
end
