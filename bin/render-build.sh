#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
yarn install
rails assets:precompile 
rake rails assets:precompile
rake rails assets:clean
rake rails db:migrate
#!/usr/bin/env bash
# exit on error
#set -o errexit

#bundle install
#bundle exec rake rails assets:precompile
#bundle exec rake assets:clean
#bundle exec rake db:migrate