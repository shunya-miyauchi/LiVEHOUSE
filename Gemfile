source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

# Default
gem 'bootsnap', '>= 1.4.2', require: false
gem 'jbuilder', '~> 2.7'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.3'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'webpacker', '~> 5.0'

# Add
gem 'activerecord-import'
gem 'cancancan'
gem 'carrierwave'
gem 'devise'
gem 'devise-i18n'
gem 'mini_magick'
gem 'nokogiri'
gem 'rails_admin', '~> 3.0'
gem 'rexml'
gem 'geocoder'

group :development, :test do
  # Default
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  # Debug
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry-rails'

  # Add
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'launchy'
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
end

group :development do
  # Default
  gem 'listen', '~> 3.2'
  gem 'rubocop', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  # Default
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
