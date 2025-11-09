# Use official Ruby image
FROM ruby:3.2

# Install system dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set working directory
WORKDIR /app

# Copy Gemfile first to leverage Docker layer caching
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

RUN rails db:migrate

# Copy the rest of the app
COPY . .

# Expose port
EXPOSE 3000

# Default command to run Rails server
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
