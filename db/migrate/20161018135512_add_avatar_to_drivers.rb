class AddAvatarToDrivers < ActiveRecord::Migration[5.0]
  def up
    add_attachment :drivers, :avatar
  end

  def down
    remove_attachment :drivers, :avatar
  end
end
