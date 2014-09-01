# Prepare environment for loading Rails
require_relative 'boot'

# Load Rails
require 'rails/all'

# Load utility functions
require_all 'lib/utilities'

# Require all gems for this application + environment
Bundler.require :default, Rails.env

# Create and configure application
module Binder
  class Application < Rails::Application
    # Cache application code when web server starts
    config.cache_classes = true

    # Filter secure parameters when logging
    config.filter_parameters += [:password]

    # Only allow setting the locale to one for which translations exist
    config.i18n.enforce_available_locales = true

    # Set default locale to 'Murican English
    # NOTE: This has to be set after enforce_available_locales because
    # apparently Rails hates idempotence and/or alphabetical order
    config.i18n.default_locale = :en

    # Load translations recursively
    config.i18n.load_path += Dir[Rails.root.join('config/locales/**/*.{rb,yml}')]
  end
end
