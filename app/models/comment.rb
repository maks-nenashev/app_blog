class Comment < ApplicationRecord
  include Commentable # Podkluczenie "Tweets"
  include Authorship  # Podkluczenie "Autor" Awtorizacija
  
  #has_one_attached :image # Foto!
  has_many_attached :images
  
  validates :body, presence: true, length: {minimum: 3} #walidacija
  belongs_to :article
  belongs_to :user
end
