require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups) if defined?(Bundler)

module RailsEcommProject
  class Application < Rails::Application
    # Set the default encoding used in templates for Ruby 1.9 and above.
    config.encoding = "utf-8"

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # Configure the default locale to :en and auto-load all translations from config/locales/*.rb,yml.
    # config.i18n.default_locale = :de

    # Filter sensitive parameters from the logs for security.
    config.filter_parameters += [:password, :password_confirmation]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is helpful if your schema cannot be completely dumped by the schema dumper, 
    # like when using a database-specific column type.
    # config.active_record.schema_format = :sql

    # Enable the asset pipeline and configure versioning.
    config.assets.enabled = true
    config.assets.version = '1.0'

    # Add custom directories with classes and modules to autoload.
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)

    # Ensure assets are not precompiled during deployment.
    config.assets.initialize_on_precompile = false

    # Load dotenv in development and test environments for environment variables.
    if Rails.env.development? || Rails.env.test?
      require 'dotenv/load'
    end
  end

  module YourAppName
  class Application < Rails::Application
    # Add the node_modules folder to the asset load path
    config.assets.paths << Rails.root.join('node_modules')
  end
end
end
