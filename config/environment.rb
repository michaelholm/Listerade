# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Mongo::Application.initialize!


require 'will_paginate'

ActionMailer::Base.smtp_settings = {
  :user_name => "app1097050@heroku.com",
  :password => "k3ucnfee",
  :domain => "stark-sunset.heroku.com",
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}