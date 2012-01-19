# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
GrapevineNotify::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => "app1838699@heroku.com",
  :password => "hci3djeh",
  :domain => "pickgrapevine.com",
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
