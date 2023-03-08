class Tweet < ApplicationRecord
  include Authorship  # Podkluczenie "Autor" Awtorizacija
  
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :body, presence: true, length: {minimum: 2} # Walidacija

end
