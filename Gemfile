source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.3"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 5.2.3"
# Use postgresql as the database for Active Record
gem "pg", ">= 0.18", "< 2.0"
# Use Puma as the app server
gem "puma", "~> 3.11"
# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem "coffee-rails", "~> 4.2"
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "turbolinks", "~> 5"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.5"
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.1.0", require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "rspec-rails"
  gem "rspec-collection_matchers"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "webpacker", "~> 3.5", ">= 3.5.5"
gem "devise", "~> 4.6", ">= 4.6.2"
gem "devise_masquerade", "~> 0.6.5"
gem "friendly_id", "~> 5.2", ">= 5.2.4"
gem "name_of_person", "~> 1.0"
gem "storext", "~> 2.2", ">= 2.2.2"
gem "premailer-rails", "~> 1.10", ">= 1.10.2"

gem "delayed_job_web"
gem "delayed_job_active_record"
gem "daemons"

gem "validate_url"
gem "httparty"
gem "feedjira"
gem "instagrammer"
gem "capybara"
gem "rollbar"
gem "nokogiri"

group :development do
  gem "rufo"
  gem "letter_opener", "~> 1.6"
  gem "foreman", "~> 0.85.0"
end

gem "stripe", "~> 4.18.1"
gem "stripe_event", "~> 2.2"
gem "receipts", "~> 0.2.2"
