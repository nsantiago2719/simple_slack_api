# Default gem source
source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

gem 'bcrypt_pbkdf'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'ed25519'
gem 'httpclient'
gem 'pg', '>= 0.18', '< 2.0'
gem 'rails', '~> 5.2.3'
gem 'sentry-raven'
gem 'listen', '>= 3.0.5', '< 3.2'
gem 'figaro'

group :development, :test do
  gem 'byebug'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'simplecov', require: false
end

group :production do
  gem "passenger", ">= 5.0.25", require: "phusion_passenger/rack_handler"
end

group :development do
  gem 'better_errors'
  gem 'capistrano', '~> 3.10', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano-passenger', require: false
  gem 'capistrano-rails', '~> 1.4', require: false
  gem 'capistrano-secrets-yml', require: false
  gem 'edukasyon-style', github: 'nsantiago2719/edukasyon-style'
  gem 'pry'
  gem 'puma', '~> 3.11'
  gem 'rubocop', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

