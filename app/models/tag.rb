class Tag < ApplicationRecord
              # Многие-ко-многим
    has_many :article_tags, dependent: :destroy
    has_many :articles, through: :article_tags

end
