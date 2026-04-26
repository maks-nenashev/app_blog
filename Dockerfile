FROM ruby:3.2.9

# 1. Установка системных зависимостей + Node.js и Yarn
# Мы добавляем официальный репозиторий Node.js, чтобы версия была актуальной для Rails 7
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    git \
    nodejs \
    ca-certificates \
    curl \
    libvips \
    libvips-dev && \
    npm install -g yarn && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 2. Установка зависимостей Ruby
COPY Gemfile Gemfile.lock ./
RUN git init && gem install bundler && bundle install

# 3. Копирование кода приложения
COPY . .

# 4. Предварительная компиляция ассетов (Production-only)
# SECRET_KEY_BASE_DUMMY позволяет собрать ассеты без доступа к реальным секретам
RUN RAILS_ENV=production SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

EXPOSE 3000

# 5. Скрипт запуска с очисткой PID-файла
CMD ["sh", "-c", "rm -f tmp/pids/server.pid && bundle exec rails s -p 3000 -b '0.0.0.0'"]