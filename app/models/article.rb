class Article < ApplicationRecord
    include Commentable # Podkluczenie "Tweet"
    include Authorship  # Podkluczenie "Autor" Awtorizacija
    mount_uploader :avatar, AvatarUploader # Podkluczenie "Foto"
    
    validates :title, presence: true, length: {minimum: 3} #walidacija
    validates :text, presence: true, length: {minimum: 3}
#/////////////////////////////////////////////////////////////////////////////////////////
           # podkluczil "user"
    has_many :comments, dependent: :destroy #:delete_all :destroy ---=Dla udalenija Comentarija wmeste s Article
    belongs_to :user
    
           # Многие-ко-многим
    has_many :article_tags, dependent: :destroy
    has_many :tags, through: :article_tags


end
