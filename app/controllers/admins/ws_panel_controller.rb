class Admins::WsPanelController < WebsocketRails::BaseController

  def initialize_session
    # perform application setup here
    controller_store[:message_count] = 0
  end

  def disable_admin
    if !current_admin.nil? && current_admin.active == true
      @admin = Admin.find_for_authentication(id: message[:id])
      @admin.active = false
      if current_admin.id != @admin.id && !last_admin? && @admin.save
        send_message :xnotice, 'message' => 'Status: Inactive - success.'
        data = { 'id' => message[:id], 'role' => 'admin', 'active' => false }
        broadcast_message :get_changed_status, data
      else
        message = 'Disable ERROR: ' + @admin.errors.details.to_s
        send_message :xnotice, 'message' => message
      end
    end
  end

  def enable_admin
    if !current_admin.nil? && current_admin.active == true
      @admin = Admin.find_for_authentication(id: message[:id])
      @admin.active = true
      if @admin.save
        send_message :xnotice, 'message' => 'Status: Active - success.'
        data = { 'id' => message[:id], 'role' => 'admin', 'active' => true }
        broadcast_message :get_changed_status, data
      else
        message = 'Enable ERROR: ' + @admin.errors.details.to_s
        send_message :xnotice, 'message' => message
      end
    end
  end

  def disable_dispatcher
    if !current_admin.nil? && current_admin.active == true
      @dispatcher = Dispatcher.find_for_authentication(id: message[:id])
      @dispatcher.active = false
      if @dispatcher.save
        send_message :xnotice, 'message' => 'Status: Inactive - success.'
        data = { 'id' => message[:id], 'role' => 'dispatcher', 'active' => false }
        broadcast_message :get_changed_status, data
      else
        message = 'Disable ERROR: ' + @dispatcher.errors.details.to_s
        send_message :xnotice, 'message' => message
      end
    end
  end

  def enable_dispatcher
    if !current_admin.nil? && current_admin.active == true
      @dispatcher = Dispatcher.find_for_authentication(id: message[:id])
      @dispatcher.active = true
      if @dispatcher.save
        send_message :xnotice, 'message' => 'Status: Active - success.'
        data = { 'id' => message[:id], 'role' => 'dispatcher', 'active' => true }
        broadcast_message :get_changed_status, data
      else
        message = 'Enable ERROR: ' + @dispatcher.errors.details.to_s
        send_message :xnotice, 'message' => message
      end
    end
  end

  def disable_driver
    if !current_admin.nil? && current_admin.active == true
      @driver = Driver.find_for_authentication(id: message[:id])
      @driver.active = false
      if @driver.save
        send_message :xnotice, 'message' => 'Status: Inactive - success.'
        data = { 'id' => message[:id], 'role' => 'driver', 'active' => false }
        broadcast_message :get_changed_status, data
      else
        message = 'Disable ERROR: ' + @driver.errors.details.to_s
        send_message :xnotice, 'message' => message
      end
    end
  end

  def enable_driver
    if !current_admin.nil? && current_admin.active == true
      @driver = Driver.find_for_authentication(id: message[:id])
      @driver.active = true
      if @driver.save
        send_message :xnotice, 'message' => 'Status: Active - success.'
        data = { 'id' => message[:id], 'role' => 'driver', 'active' => true }
        broadcast_message :get_changed_status, data
      else
        message = 'Enable ERROR: ' + @driver.errors.details.to_s
        send_message :xnotice, 'message' => message
      end
    end
  end


  def new_admin
    if !current_admin.nil? && current_admin.active == true
      if !Admin.find_for_authentication(login: message[:login]).nil?
        send_message :xnotice, 'message' => 'Admin with this login already exists'
      else
        @admin = Admin.new(login: message[:login], password: message[:password])
        @admin.active = true
        if @admin.save
          send_message :xnotice, 'message' => 'New admin successfully created'
          admin_data = { 'type' => 'admin', 'login' => @admin.login, 'id' => @admin.id }
          admin_data[:author] = current_admin.id
          broadcast_message :get_new_admin_data, admin_data
        else
          message = 'Create ERROR: ' + @admin.errors.details.to_s
          send_message :xnotice, 'message' => message
        end
      end
    end
  end


  def edit_admin
    if !current_admin.nil? && current_admin.active == true
      @admin = Admin.find_for_authentication(id: message[:id])
      @admin.encrypted_password = Admin.new(password: message[:password]).encrypted_password
      if @admin.save
        send_message :xnotice, 'message' => 'Password changed successfully'
      else
        message = 'Edit ERROR: ' + @admin.errors.details.to_s
        send_message :xnotice, 'message' => message
      end
    end
  end


  def new_dispatcher
    if !current_admin.nil? && current_admin.active == true
      if !Dispatcher.find_for_authentication(email: message[:email]).nil?
        send_message :xnotice, 'message' => 'Dispatcher with this email already exists'
      else
        @dispatcher = Dispatcher.new(email: message[:email], password: message[:password])
        @dispatcher.active = true
        if @dispatcher.save
          send_message :xnotice, 'message' => 'New Dispatcher successfully created'
          dispatcher_data = { 'type' => 'dispatcher', 'login' => @dispatcher.email, 'id' => @dispatcher.id }
          dispatcher_data[:author] = current_admin.id
          broadcast_message :get_new_dispatcher_data, dispatcher_data
        else
          message = 'Create ERROR: ' + @dispatcher.errors.details.to_s
          send_message :xnotice, 'message' => message
        end
      end
    end
  end


  def edit_dispatcher
    if !current_admin.nil? && current_admin.active == true
      if !message[:email].nil? && !Dispatcher.find_for_authentication(email: message[:email]).nil?
        send_message :xnotice, 'message' => 'Dispatcher with this email already exists'
      else
        @dispatcher = Dispatcher.find_for_authentication(id: message[:id])
        dispatcher_data = { 'id' => @dispatcher.id }
        unless message[:email].nil?
          @dispatcher.email = message[:email]
          dispatcher_data[:email] = message[:email]
        end
        unless message[:password].nil?
          @dispatcher.encrypted_password = Dispatcher.new(password: message[:password]).encrypted_password
        end
        if @dispatcher.save
          send_message :xnotice, 'message' => 'Changes successfully saved'
          dispatcher_data[:author] = current_admin.id
          broadcast_message :get_edit_dispatcher_data, dispatcher_data
        else
          message = 'Edit ERROR: ' + @dispatcher.errors.details.to_s
          send_message :xnotice, 'message' => message
        end
      end
    end
  end


  def new_driver
    if !current_admin.nil? && current_admin.active == true
      if !Driver.find_for_authentication(phone: message[:phone]).nil?
        send_message :xnotice, 'message' => 'Driver with this phone already exists'
      else
        @driver = Driver.new(phone: message[:phone], password: message[:password])
        @driver.active = true
        @driver.name = message[:name]
        @driver.car_type = message[:car_type]
        @driver.passengers = message[:passengers].to_i
        @driver.trunk = message[:trunk].to_i
        if @driver.save
          send_message :xnotice, 'message' => 'New Driver successfully created'
          driver_data = { 'type' => 'driver', 'login' => @driver.phone, 'id' => @driver.id }
          driver_data[:name] = @driver.name
          driver_data[:author] = current_admin.id
          broadcast_message :get_new_driver_data, driver_data
        else
          message = 'Create ERROR: ' + @driver.errors.details.to_s
          send_message :xnotice, 'message' => message
        end
      end
    end
  end


  def get_driver_data
    if !current_admin.nil? && current_admin.active == true
      @driver = Driver.find_for_authentication(id: message[:id])
      driver_data = @driver.as_json
      if message[:action] == 'details'
        send_message :open_details, driver_data
      elsif message[:action] == 'edit'
        send_message :edit_driver, driver_data
      end
    end
  end


  def edit_driver
    if !current_admin.nil? && current_admin.active == true
      if !message[:phone].nil? && !Driver.find_for_authentication(phone: message[:phone]).nil?
        send_message :xnotice, 'message' => 'Driver with this phone already exists'
      else
        @driver = Driver.find_for_authentication(id: message[:id])
        driver_data = { 'id' => @driver.id }
        unless message[:phone].nil?
          @driver.phone = message[:phone]
          driver_data[:phone] = message[:phone]
        end
        unless message[:password].nil?
          @driver.encrypted_password = Driver.new(password: message[:password]).encrypted_password
        end
        @driver.name = message[:name]
        driver_data[:name] = message[:name]
        @driver.car_type = message[:car_type]
        @driver.passengers = message[:passengers].to_i
        @driver.trunk = message[:trunk].to_i
        if @driver.save
          send_message :xnotice, 'message' => 'Changes successfully saved'
          driver_data[:author] = current_admin.id
          broadcast_message :get_edit_driver_data, driver_data
        else
          message = 'Edit ERROR: ' + @driver.errors.details.to_s
          send_message :xnotice, 'message' => message
        end
      end
    end
  end

  def driver_avatar
    if !current_admin.nil? && current_admin.active == true
      @driver = Driver.find_for_authentication(id: message[:id])
      driver_data = { 'id' => @driver.id }
      driver_data[:thumb] = @driver.avatar.url(:thumb)
      driver_data[:medium] = @driver.avatar.url(:medium)
      broadcast_message :update_avatar, driver_data
    end
  end

  private

  def last_admin?
    Admin.where(active: true).count == 1 ? true : false
  end
end
