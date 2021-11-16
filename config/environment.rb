# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!
ActionMailer::Base.smtp_settings = {
  address: "smtp.gmail.com",
  port: 587,
  user_name: ENV["EMAIL_USERNAME"],
  password: ENV["EMAIL_PASSWORD"],
  domain: "localhost",
  authentication: :plain,
  enable_starttls_auto: true
}
