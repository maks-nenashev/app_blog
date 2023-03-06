set -o errexit

bundle install
yarn build
bundle exec rake rails assets:precompile 
bundle exec rake rails assets:clean
bundle exec rake rails db:migrate