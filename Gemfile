source 'https://rubygems.org'

gem 'figaro'
gem 'devise'
gem 'angularjs-rails'
gem 'angular-ui-bootstrap-rails'
gem 'bootstrap-sass'
gem 'turbolinks'
gem 'kaminari'
gem 'paperclip'
gem 'bootstrap-kaminari-views'
gem 'rufus-scheduler'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use Puma as the app server
gem 'puma'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer'
gem 'sprockets', '~> 3.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'pg'
gem 'faye-websocket', '0.10.0'
gem 'websocket-rails', github: 'moaa/websocket-rails', branch: 'threadsocket-rails'
gem 'websocket-rails-js', github: 'websocket-rails/websocket-rails-js', branch: 'sub_protocols'

group :development, :test do
  gem "rspec-rails"
  gem "factory_girl_rails"
  gem "faker"
  gem 'byebug', platform: :mri
end

group :test do
  gem "capybara"
  gem "database_cleaner"
  gem "launchy"
  gem "selenium-webdriver"
end

group :development do
  gem 'capistrano-secrets-yml'
  gem 'capistrano',         require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma',   require: false
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'pry-rails'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'listen'
# Windows (o.O?) does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
