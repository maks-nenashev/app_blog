#!/usr/bin/env bash
# exit on error
set -o errexit


bundle install
bundle exec rails rake assets:precompile
bundle exec rails rake assets:clean
bundle exec rails rake db:migrate
