require_relative 'boot'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SlobodaTeam
  class Application < Rails::Application
    Figaro.load
    ENV['SET_BY_FIGARO'] # => nil
    Figaro.env.SET_BY_FIGARO

     config.action_mailer.raise_delivery_errors = false
     config.action_mailer.delivery_method = :smtp
     config.action_mailer.smtp_settings = {
        address:              'smtp.gmail.com',
        port:                 587,
        user_name:            ENV['GMAIL_USERNAME'],
        password:             ENV['GMAIL_PASSWORD'],
        authentication:       'plain',
        enable_starttls_auto: true
    }

    config.assets.paths << Rails.root.join("vendor","assets","bower_components")
    config.assets.paths << Rails.root.join("vendor","assets","bower_components","bootstrap-sass-official","assets","fonts")
    config.assets.precompile << %r(.*.(?:eot|svg|ttf|woff|woff2)$)
    config.assets.paths << Rails.root.join("vendor","assets","bower_components","bootstrap-sass-official","assets","fonts")

    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: true,
        request_specs: false
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end

    config.middleware.delete Rack::Lock

    WebsocketRails.users.users['admin'] = WebsocketRails::UserManager.new
    WebsocketRails.users.users['driver'] = WebsocketRails::UserManager.new
    WebsocketRails.users.users['dispatcher'] = WebsocketRails::UserManager.new

  end
end
