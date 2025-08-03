FROM ruby:3.2

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libsqlite3-dev \
  nodejs \
  ca-certificates \
  curl \
  libvips \
  libvips-dev

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN curl https://rubygems.org # проверка интернет-доступности
RUN gem install bundler
RUN bundle install

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]

