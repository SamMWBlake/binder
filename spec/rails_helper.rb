# Load Rails environment configuration under test
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path "../../config/environment", __FILE__

# Require RSpec
require 'rspec/rails'
require 'spec_helper'

# Check for pending migrations before tests are run
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Make route helpers available in specs
  config.include Rails.application.routes.url_helpers

  # Disable automatic use of transactional fixtures
  # NOTE: Transactions are instead enabled selectively by Database Cleaner
  config.use_transactional_fixtures = false
end
