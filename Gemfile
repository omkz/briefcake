# frozen_string_literal: true
source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma'
# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby
gem 'php_serialize'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
#gem "jbuilder", "~> 2.5"
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

gem 'valid_email2'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'minitest-matchers'
  gem 'email_spec'
  gem 'pry-rails'
  gem 'timecop'
  gem 'vcr'
  gem 'webmock'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'factory_bot_rails', require: false
  gem 'minitest-stub_any_instance'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.3'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring

  gem 'foreman', '~> 0.86.0'
  gem 'letter_opener', '~> 1.6'
  gem 'pry'
  gem 'rufo'
end

group :production do # don't drop by debugging session on development, please
  gem "rack-timeout"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'devise', '~> 4.7'
gem 'devise_masquerade'
gem 'friendly_id', '~> 5.3'
gem 'name_of_person', '~> 1.0'
gem 'premailer-rails', '~> 1.10'
gem 'storext', '~> 3.1'
gem 'webpacker', '~> 3.5', '>= 3.5.5'

gem 'good_job'
gem 'activerecord-typedstore'

gem 'feedjira'
gem 'honeybadger'
gem 'httparty'
gem 'nokogiri'
gem 'validate_url'

gem 'browser', '~> 4.2'
gem "http"
gem "barnes" # used to report GC stats to heroku

