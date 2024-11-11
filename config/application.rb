require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # Require gems as per the current Rails environment
  Bundler.require(*Rails.groups)
end

module RailsEcommProject
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # Set the default locale to :en and auto-load all translations from config/locales/*.rb,yml.
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9 and above.
    config.encoding = "utf-8"

    # Filter sensitive parameters from logs.
    config.filter_parameters += [:password]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # config.active_record.schema_format = :sql

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets; change to invalidate cached assets.
    config.assets.version = '1.0'

    # Add custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)

    # Ensure assets are not precompiled during deployment.
    config.assets.initialize_on_precompile = false
  end
end
