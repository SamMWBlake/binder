# Require Capybara to simulate user interactions in integration tests
require 'capybara/rails'
require 'capybara/rspec'

# Use Poltergeist to automate JavaScript interactions in a headless browser
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist
