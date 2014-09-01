Binder::Application.configure do
  # Enable caching
  config.action_controller.perform_caching = true

  # Set options for links in emails
  config.action_mailer.default_url_options = {
    protocol: :http,
    host:     "emptyorchestra.co"
  }

  # Send emails via Mailgun
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    authentication: :plain,
    address:        "smtp.mailgun.org",
    port:           587,
    domain:         "mail.emptyorchestra.co",
    user_name:      "postmaster@mail.emptyorchestra.co",
    password:       "7dbd0b86693f121aef2521f943a3c9d0"
  }

  # Send deprecation notices to registered listeners (e.g. web server logs)
  config.active_support.deprecation = :notify

  # Don't compile assets on the fly (requires precompilation)
  config.assets.compile = false

  # Compress assets
  config.assets.compress = true

  # Fingerprint asset files
  config.assets.digest = true

  # Compress JavaScript with Uglifier
  config.assets.js_compressor = :uglifier

  # Load code on boot
  config.eager_load = true

  # Fall back to the default locale if a translation can't be found
  config.i18n.fallbacks = true

  # Format logs with all data (including PID and timestamp)
  config.log_formatter = ::Logger::Formatter.new

  # Minimize logging
  config.log_level = :info

  # Disable Rails's static asset server (let web server serve assets)
  config.serve_static_assets = false
end
