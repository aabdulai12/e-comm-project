source 'https://rubygems.org'

# Bundler version
gem 'bundler', '~> 2.5.22'

# Rails version
gem 'rails', '~> 6.1.7'




# General dependencies
gem 'faker'                 # Generate fake data for testing
gem 'devise'                # Authentication solution
gem 'redis-rails'           # Redis integration for Rails
gem 'httparty'              # HTTP requests library
gem 'nokogiri', '1.13.1'    # XML and HTML parsing
gem 'stripe'                # Payment processing
gem 'dotenv-rails', groups: [:development, :test] # Environment variable management

# JavaScript and CSS Assets
gem 'bootstrap', '~> 5.3.0' # Bootstrap 5 integration
gem 'sass-rails', '~> 6.0'  # Sass integration for Rails 6.x
gem 'jquery-rails', '>= 4.3.1' # jQuery for Rails
gem 'ffi', '~> 1.15' # Use a compatible version
# Admin functionality
gem 'activeadmin', '~> 2.9'   # Admin dashboard
gem 'ckeditor'                # WYSIWYG editor for content

# File uploads
gem 'paperclip', '~> 6.1'     # File attachment (consider Active Storage for newer apps)

# Search functionality
gem 'ransack'                 # Advanced search capabilities
gem 'scoped_search'           # Scoped search for models

# Payment processing
gem 'paypal-checkout-sdk'     # PayPal SDK for Checkout
gem 'paypal-sdk-rest'         # PayPal REST SDK

# Other tools
gem 'haml-rails'              # HAML templating engine
gem 'excon', '~> 0.80'        # HTTP client library
gem 'addressable', '~> 2.8'   # URL parsing library
gem 'activemerchant'          # Payment gateway integrations

# JavaScript and CSS compression
group :assets do
  gem 'uglifier', '>= 1.0.3'   # JavaScript compressor
end

# Development and testing
group :development, :test do
  gem 'sqlite3', '~> 1.4'       # SQLite for development and testing
  gem 'dotenv-rails'            # Manage environment variables
end

# Production
group :production do
  gem 'mysql2', '>= 0.5'        # MySQL for production
  gem 'thin'                    # Lightweight web server
end

# Linters and coding standards
gem 'rubocop'                   # Ruby linter
gem 'rubocop-rails'             # Rails-specific linting

# Remove duplicates
# Removed extra redis-rails, stripe, devise, and dotenv-rails declarations
