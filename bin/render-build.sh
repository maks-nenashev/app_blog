#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
yarn install
rails assets:precompile 
rails assets:clean
#rake db:migrate
rake db:migrate #RAILS_ENV=production
#!/usr/bin/env bash
# exit on error
#set -o errexit

#bundle install
#bundle exec rake rails assets:precompile
#bundle exec rake assets:clean
#bundle exec rake db:migrate