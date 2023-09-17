source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.4", ">= 7.0.4.2"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use sqlite3 as the database for Active Record
gem "sqlite3", "~> 1.4"
gem 'pg', '~> 1.4', '>= 1.4.6'
#gem 'pg'#,'~> 1.4.3'
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"
gem 'sassc-rails', '~> 2.1', '>= 2.1.2'
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"


gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false
 
gem 'foreman'
gem 'rails-i18n'
gem 'caxlsx','~> 3.1'
gem 'caxlsx_rails','~> 0.6'
gem 'rubyzip', '~> 2.3', '>= 2.3.2'
gem 'rubyXL', '~> 3.4'
gem 'activerecord-import', '~> 1.2'
#//////////////////////////////////////////////////
gem 'carrierwave', '>= 3.0.0.beta', '< 4.0'
gem 'pagy','~> 6.0.2'

gem 'draper' # Dekorator
gem 'devise'
gem 'pundit'
gem 'sidekiq', '~> 6'
gem 'uglifier' #Dla normalnoj raboty :rails assets:precompile

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"
  
group :development, :test do
  #gem 'faker','~> 3.1.1'
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'faker','~> 3.1.1'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
  gem 'bullet'
  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
#//////////////////////////////////////////////////
