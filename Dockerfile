FROM ruby:3.0

# Install required system packages
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Install a specific version of Bundler
RUN gem install bundler -v 2.5.22

# Set working directory
WORKDIR /app

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Update ffi gem explicitly
RUN bundle update ffi

# Install dependencies
RUN bundle install

# Copy the application code
COPY . ./

# Precompile assets
RUN RAILS_ENV=production bundle exec rake assets:precompile

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
