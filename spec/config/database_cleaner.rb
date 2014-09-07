require 'database_cleaner'

RSpec.configure do |config|
  config.before :suite do
    # Completely purge the database before starting tests
    DatabaseCleaner.clean_with :truncation
  end

  config.before :each do
    # Test with transactions for speed
    DatabaseCleaner.strategy = :transaction
  end

  config.before :each, js: true do
    # Use truncations for JavaScript-enabled tests, which run in a separate thread
    DatabaseCleaner.strategy = :truncation
  end

  config.before :each do
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end
end
