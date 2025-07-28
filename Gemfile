source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.9" # или 3.2.0 для локальной разработки

# --- Rails & ядро ---
gem "rails", "~> 7.0.4", ">= 7.0.4.2"
gem "puma", "~> 5.0"
gem "bootsnap", require: false # ускорение загрузки

# --- Active Record, базы данных ---
gem "sqlite3", "~> 1.4"
gem "pg",     "~> 1.4", ">= 1.4.6"
gem "activerecord-import", "~> 1.2"

# --- Аутентификация, авторизация, OAuth, загрузка файлов ---
gem "devise"
gem "pundit"
gem "omniauth"
gem "omniauth-google-oauth2"
gem "omniauth-rails_csrf_protection", "~> 1.0"
gem "gravatar_image_tag", github: "mdeering/gravatar_image_tag"
gem "aws-sdk-s3", require: false

# --- Интернационализация, локализация ---
gem "rails-i18n"

# --- Фронтенд, CSS, JS, Turbo, Stimulus, Sprockets ---
gem "jsbundling-rails"
gem "cssbundling-rails"
gem "sassc-rails",    "~> 2.1", ">= 2.1.2"
gem "turbo-rails"
gem "stimulus-rails"
gem "sprockets-rails"
gem "uglifier" # для :rails assets:precompile

# --- Фоновая обработка, очереди ---
gem "sidekiq", "~> 6"
gem "foreman" # Procfile manager

# --- Отчёты, экспорты, Excel, ZIP ---
gem "caxlsx",        "~> 3.1"
gem "caxlsx_rails",  "~> 0.6"
gem "rubyzip",       "~> 2.3", ">= 2.3.2"
gem "rubyXL",        "~> 3.4"
gem "image_processing", "~> 1.2"

# --- Пагинация, декораторы, другие удобства ---
gem "pagy",   "~> 6.0.2"
gem "draper"

# --- Строители JSON и данных ---
gem "jbuilder"

# --- Платформенные зависимости ---
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

# --- Разработка и отладка ---
group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
  # gem "faker", "~> 3.1.1"
end

group :development do
  gem "web-console"
  gem "bullet"
  # gem "rack-mini-profiler"
  # gem "spring"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end

# --- Альтернативные или устаревшие библиотеки (оставлены для справки) ---
# gem "ruby-vips", "~> 2.1", ">= 2.1.4"
# gem "sassc-rails"
