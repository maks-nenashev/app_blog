class TweetDecorator < ApplicationDecorator
    delegate_all
    decorates_association :user
  
    # Что бы разделить вывод ошибки в полимерфии
  def for?(commentable)
    commentable = commentable.object if commentable.decorated?

    commentable == self.commentable
    end
 end
  