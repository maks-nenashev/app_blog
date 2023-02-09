class Comment < ApplicationRecord
  validates :body, presence: true, length: {minimum: 3} #walidacija
  belongs_to :article
end
