Rails.application.routes.draw do

root 'orders#index'
resources :orders, except: [:update]
resources :orders_blogs

devise_for :dispatchers
  as :dispatcher do
    get 'dispatchers/orders'
    get 'dispatchers/drivers'
    get 'dispatcher' => 'devise/sessions#new', :as => :new_dispatchers_session
    post 'dispatcher' => 'devise/sessions#create', :as => :dispatchers_session
    delete 'dispatcher' => 'devise/sessions#destroy', :as => :destroy_dispatchers_session
    get 'dispatchers/profile' => 'dispatchers/profile', :as => :dispatcher_root
 end

devise_for :drivers, skip: :all, controllers: { sessions: 'drivers/sessions' }
  as :driver do
    get 'driver' => 'devise/sessions#new', as: :new_driver_session
    post 'driver' => 'devise/sessions#create', as: :driver_session
    delete 'driver' => 'devise/sessions#destroy', as: :destroy_driver_session
    get 'drivers/orders', as: :driver_root
    put 'drivers/orders/:id' => 'drivers#update_order'
  end

devise_for :admins, path: 'admin', skip: :registrations, controllers: { sessions: 'admins/sessions' }
  devise_scope :admin do
    get '/admin/panel/driver_photo/:id', to: 'admins/panel#edit_driver_photo'
    post '/admin/panel/driver_photo/:id', to: 'admins/panel#update_driver_photo'
    get '/admin/panel/action_log', to: 'admins/panel#action_log'
    get '/admin', to: 'admins/sessions#new'
    get '/admins' => 'admins/panel#index', as: :admin_root
  end

end
