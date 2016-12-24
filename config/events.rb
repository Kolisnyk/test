WebsocketRails::EventMap.describe do
  # You can use this file to map incoming events to controller actions.
  # One event can be mapped to any number of controller actions. The
  # actions will be executed in the order they were subscribed.
  #
  # Uncomment and edit the next line to handle the client connected event:
  #   subscribe :client_connected, :to => Controller, :with_method => :method_name
  #
  # Here is an example of mapping namespaced events:
  #   namespace :product do
  #     subscribe :new, :to => ProductController, :with_method => :new_product
  #   end
  # The above will handle an event triggered on the client like `product.new`.

  # Connection controller
  subscribe :client_connected, to: WsConnectionController, with_method: :client_connected
  subscribe :client_disconnected, to: WsConnectionController, with_method: :delete_user
  subscribe :connection_closed, to: WsConnectionController, with_method: :delete_user

  # Admin section
  subscribe :disable_admin, to: Admins::WsPanelController, with_method: :disable_admin
  subscribe :enable_admin, to: Admins::WsPanelController, with_method: :enable_admin
  subscribe :disable_dispatcher, to: Admins::WsPanelController, with_method: :disable_dispatcher
  subscribe :enable_dispatcher, to: Admins::WsPanelController, with_method: :enable_dispatcher
  subscribe :disable_driver, to: Admins::WsPanelController, with_method: :disable_driver
  subscribe :enable_driver, to: Admins::WsPanelController, with_method: :enable_driver
  subscribe :new_admin, to: Admins::WsPanelController, with_method: :new_admin
  subscribe :edit_admin, to: Admins::WsPanelController, with_method: :edit_admin
  subscribe :new_dispatcher, to: Admins::WsPanelController, with_method: :new_dispatcher
  subscribe :edit_dispatcher, to: Admins::WsPanelController, with_method: :edit_dispatcher
  subscribe :new_driver, to: Admins::WsPanelController, with_method: :new_driver
  subscribe :get_driver_data, to: Admins::WsPanelController, with_method: :get_driver_data
  subscribe :edit_driver, to: Admins::WsPanelController, with_method: :edit_driver
  subscribe :driver_avatar, to: Admins::WsPanelController, with_method: :driver_avatar

  # Core
  subscribe :refresh, to: WsCoreController, with_method: :refresh
  subscribe :pong, to: WsConnectionController, with_method: :client_connected
end
