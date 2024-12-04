RailsEcommProject::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb
  
  # Code is not reloaded between requests
  config.cache_classes = true

  # Eager load code on boot
  config.eager_load = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Enable Rails's static asset server (useful for Docker setups)
  config.serve_static_assets = true

  # Compress JavaScripts and CSS
  config.assets.js_compressor = :uglifier
  config.assets.css_compressor = :sass

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = false

  # Generate digests for assets URLs
  config.assets.digest = true

  # Specifies the header that your server uses for sending files
  config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Use SSL for production
  config.force_ssl = true

  # Log level
  config.log_level = :info

  # Prepend all log lines with the following tags
  config.log_tags = [:request_id]

  # Use a different cache store in production
  config.cache_store = :memory_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  config.action_controller.asset_host = ENV.fetch("ASSET_HOST", "http://assets.example.com")

  # Precompile additional assets
  config.assets.precompile += %w(search.js)

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  # Use default logging formatter to avoid suppressing PID and timestamp
  config.log_formatter = ::Logger::Formatter.new

  # Log to STDOUT if running in a Docker container
  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end

  # Do not dump schema after migrations
  config.active_record.dump_schema_after_migration = false
end
