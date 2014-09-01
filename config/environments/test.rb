Binder::Application.configure do
  # Disable CSRF protection (avoids bogus authenticity errors in tests)
  config.action_controller.allow_forgery_protection = false

  # Disable caching
  config.action_controller.perform_caching = false

  # Raise exceptions explicitly instead of rendering exception templates
  config.action_dispatch.show_exceptions = false

  # Set options for links in emails
  config.action_mailer.default_url_options = {
    protocol: :http,
    host: "test.host"
  }

  # Send emails to ActionMailer::Base.deliveries
  config.action_mailer.delivery_method = :test

  # Print deprecation notices to stderr
  config.active_support.deprecation = :stderr

  # Show detailed debugging information
  config.consider_all_requests_local = true

  # Load code only as needed (avoids loading more than necessary per-test)
  config.eager_load = false
end
