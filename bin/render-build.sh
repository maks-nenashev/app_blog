#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
#yarn install
#rails assets:precompile 
bundle exec rake rails assets:precompile
bundle exec rake rails assets:clean

rake rails db:migrate