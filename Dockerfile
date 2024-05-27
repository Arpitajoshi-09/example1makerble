FROM ruby:3.1.0

# Set environment variables for Rails
ENV RAILS_ENV=production \
    RAILS_ROOT=/app

# Set the working directory in the container
WORKDIR $RAILS_ROOT

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Install bundler
RUN gem install bundler

# Copy the Gemfile and Gemfile.lock from the app directory
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install --without development test

# Copy the Rails application code into the container
COPY . .

# Expose port 3000 to the Docker host, so it can be accessed from outside the container
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
