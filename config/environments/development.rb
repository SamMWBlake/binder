Binder::Application.configure do
  # Disable caching
  config.action_controller.perform_caching = false

  # Set options for links in emails
  config.action_mailer.default_url_options = {
    protocol: :http,
    host:     "localhost:3000"
  }

  # Send emails to letter_opener gem for previewing rather than delivering
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.raise_delivery_errors = false

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Log deprecation notices
  config.active_support.deprecation = :log

  # Disable concatenation and preprocessing of assets
  config.assets.debug = true

  # Reload code on each request (so we don't have to restart the web server)
  config.cache_classes = false

  # Show detailed debugging information
  config.consider_all_requests_local = true

  # Load code only as needed
  config.eager_load = false

  # Customize `rails generate` output
  config.generators do |g|
    # Don't generate assets or helpers
    g.assets      = false
    g.helper      = false
    g.javascripts = false
    g.stylesheets = false

    # Generate factories rather than fixtures
    g.fixture_replacement :factory_girl, dir: "spec/factories"

    # Generate HAML rather than ERB
    g.template_engine = :haml

    # Generate RSpec specs rather than Test::Unit classes
    g.test_framework :rspec, fixture: true
  end
end
