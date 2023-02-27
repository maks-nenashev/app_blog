class TweetDecorator < ApplicationDecorator
    delegate_all
    decorates_association :user
  
   end
  