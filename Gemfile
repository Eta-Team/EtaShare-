# frozen_string_literal: true

source 'https://rubygems.org'
# ruby File.read('.ruby-version').strip
ruby '~> 3.1.1'

# Web API
gem 'json'
gem 'puma', '~>5'
gem 'roda', '~>3'

gem 'simplecov'

# Configuration
gem 'figaro', '~>1'
gem 'rake', '~>13'

# Security
gem 'bundler-audit'
gem 'rbnacl', '~>7'

# Database
gem 'hirb', '~>0'
gem 'sequel', '~>5'

group :production do
  gem 'pg'
end

# External Services
gem 'http'

# Testing
group :test do
  gem 'minitest'
  gem 'minitest-rg'
end

# Debugging
gem 'pry' # necessary for rake console

# Development
group :development do
  gem 'rerun'

  # Quality
  gem 'rubocop'
  gem 'rubocop-performance'
end

group :development, :test do
  gem 'rack-test'
  gem 'sequel-seed'
  gem 'sqlite3'
end
