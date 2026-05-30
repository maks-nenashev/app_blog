FROM ruby:3.2.9

# 1. Установка актуальной Node.js (22.x LTS) и системных зависимостей
RUN curl -sL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get update -qq && apt-get install -y --no-install-recommends \
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

# 2. Установка dependencies
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

# 3. Копирование кода
COPY . .

# Принудительное игнорирование несовместимости пакетов sass
RUN yarn config set ignore-engines true && yarn install

# Заглушка для Git
RUN git init

# 4. Предварительная компиляция ассетов
RUN RAILS_ENV=production SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

EXPOSE 3000

# 5. Инструкция запуска
CMD ["sh", "-c", "rm -f tmp/pids/server.pid && bundle exec rails s -p 3000 -b '0.0.0.0'"]