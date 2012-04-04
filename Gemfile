source 'http://rubygems.org'

gem 'rails', '3.1.3'

#Gems for analytics and measurements
gem 'newrelic_rpm'
gem 'activeadmin'

#Gems for APIs
gem "citygrid_api", :git => "git://github.com/CityGrid/citygrid_api.git"
gem 'oauth'
gem 'httparty'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

group :production do
  gem 'pg'
end

group :development do
  gem 'sqlite3'
end

group :test do
  gem 'turn', '~> 0.8.3' , :require => false
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'webrat', '0.7.3'
  gem "rspec-rails"
  gem "ZenTest", "~> 4.4.2"
  gem "autotest-rails", "~> 4.1.0"
  gem 'gimme'
end

gem 'mysql'
gem 'heroku'
gem 'nokogiri'

# Third Party Services
gem 'recurly', '~> 2.0.10'
gem 'sendgrid'
gem 'hominid'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 3.1.5'
  gem 'uglifier', '>= 1.0.3'
  gem 'coffee-rails'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
