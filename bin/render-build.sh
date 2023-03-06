#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
yarn install
bundle exec rails assets:precompile RAILS_ENV=production
bundle exec rake rails assets:clean
bundle exec rake rails db:migrate