#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
#yarn install
rails assets:precompile 
rake rails assets:clean
rake rails db:migrate