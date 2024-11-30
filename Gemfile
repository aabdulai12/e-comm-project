source 'https://rubygems.org'

# Specify your Rails version
gem 'rails', '~> 6.1.7'
# Gemfile
gem 'faker'
gem 'devise'
gem 'redis-rails'
gem 'httparty'
# Gemfile
gem 'nokogiri', '1.13.1'
gem 'stripe'
gem 'dotenv-rails', groups: [:development, :test]
gem 'bootstrap-sass', '~> 3.3.7'
gem 'bootstrap', '~> 5.3.0'

gem 'redis-rails'
gem 'dotenv-rails', groups: [:development, :test]

# Core dependencies
gem 'excon', '~> 0.80'
gem 'ransack'              # Replacement for meta_search
gem 'paypal-checkout-sdk'
gem 'paypal-sdk-rest'
gem 'stripe'


# JavaScript and CSS Assets
gem 'coffee-rails', '~> 5.0'
gem 'sass-rails', '~> 6.0' # Compatible version for Rails 6

# ActiveAdmin for admin functionality
gem 'activeadmin', '~> 2.9'  # Updated to a compatible version with Rails 6.x

# Dependencies required by ActiveAdmin and Rails 6.x
gem 'jquery-rails', '>= 4.3.1'  # Update to a compatible version with Rails 6.x
gem 'addressable', '~> 2.8'

# Paperclip for file uploads (consider switching to Active Storage in Rails 6)
gem "paperclip", "~> 6.1"   # Updated to the latest version

# Other Gems
gem 'activemerchant'        # Payment processing gem
gem 'scoped_search'         # Search functionality
gem 'haml-rails'            # HAML templating for Rails
gem 'ckeditor'              # WYSIWYG editor
gem 'devise'

# Heroku support
#gem 'heroku'

# Assets group
group :assets do
  gem 'compass'             # CSS authoring framework
  gem 'uglifier', '>= 1.0.3' # JavaScript compressor
end

# Database adapters
group :development, :test do
  gem 'sqlite3', '~> 1.4'   # Compatible with Rails 6.x
end

group :production do
  gem 'mysql2', '>= 0.5'    # Use `mysql2` for MySQL in production
  gem 'thin'
end

# Optional Dependencies
# gem 'bcrypt', '~> 3.1.7'   # Uncomment if using has_secure_password
# gem 'jbuilder'             # JSON responses
# gem 'unicorn'              # Alternative app server
# gem 'capistrano'           # For deployment
# gem 'debug', '>= 1.0.0'    # Debugger for development
