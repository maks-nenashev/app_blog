#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
yarn install
rails assets:precompile 
rails assets:clean
rake db:migrate