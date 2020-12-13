# frozen_string_literal: true
source 'https://rubygems.org'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'ejson-rails'
gem 'pg'
gem 'puma', '~> 4.1'
gem 'rails', git: 'https://github.com/rails/rails.git', branch: 'master'
gem 'sorbet-runtime'

group :development, :test do
  gem 'byebug'
  gem 'factory_bot_rails'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rubocop', '~> 0.93', require: false
  gem 'rubocop-minitest', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-shopify', require: false
  gem 'rubocop-sorbet', require: false
  gem 'sorbet'
  gem 'tapioca', git: 'https://github.com/Shopify/tapioca.git', branch: 'master', require: false
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'mocha'
end
