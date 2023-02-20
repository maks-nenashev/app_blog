class Article < ApplicationRecord
    include Commentable # Podkluczenie "commits"


    validates :title, presence: true, length: {minimum: 3} #walidacija
    validates :text, presence: true, length: {minimum: 3}
#/////////////////////////////////////////////////////////////////////////////////////////
    
    #has_many :comments  # Podkluchenie "Comments" Rukami delaem
                                
    has_many :comments, dependent: :destroy #:delete_all :destroy ---=Dla udalenija Comentarija wmeste s Article
    belongs_to :user
    # podkluczil "user"
end
