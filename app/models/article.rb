class Article < ApplicationRecord
    include Commentable # Podkluczenie "Tweet"
    include Authorship  # Podkluczenie "Autor" Awtorizacija
    mount_uploader :avatar, AvatarUploader #Podluczenie Foto
    
    validates :title, presence: true, length: {minimum: 3} #walidacija
    validates :text, presence: true, length: {minimum: 3}
#/////////////////////////////////////////////////////////////////////////////////////////
           # podkluczil "user"
    has_many :comments, dependent: :destroy #:delete_all :destroy ---=Dla udalenija Comentarija wmeste s Article
    belongs_to :user
    
     
    
end
