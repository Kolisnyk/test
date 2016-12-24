namespace :driver do
  desc 'Count done and cancelled orders foir all drivers'
  task count: :environment do
    drivers = Driver.all
    drivers.each do |driver|
      done = OrdersBlog.where(driver_id: driver.id, action: 'Done').count
      cancel = OrdersBlog.where(driver_id: driver.id, action: 'Declined').count
      if driver.update done: done, cancelled: cancel
        message = 'Driver ' + driver.id.to_s + ' updated. '
        message += 'Done: ' + done.to_s + ' | Cancelled: ' + cancel.to_s
      else
        message = 'Driver ' + driver.id.to_s + ' NOT updated. '
        message += driver.errors.to_s
      end
      puts message
    end
  end
end
