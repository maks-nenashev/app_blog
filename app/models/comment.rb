class Comment < ApplicationRecord
  include Commentable # Podkluczenie "Tweets"

  
  validates :body, presence: true, length: {minimum: 3} #walidacija
  belongs_to :article
  belongs_to :user
end
