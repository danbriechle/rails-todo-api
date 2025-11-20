# syntax=docker/dockerfile:1
# check=error=true

ARG RUBY_VERSION=3.3.4
FROM ruby:${RUBY_VERSION}-slim AS base

ENV APP_HOME=/app \
    BUNDLE_PATH=/usr/local/bundle \
    RAILS_ENV=development \
    RACK_ENV=development

# Rails app lives here
WORKDIR $APP_HOME

# Install OS deps
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      build-essential \
      libpq-dev \
      libyaml-dev \
      git \
      curl \
      nodejs && \
    rm -rf /var/lib/apt/lists/*

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy app code
COPY . .

# Expose Rails port
EXPOSE 3000

# Default command: run Rails server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
