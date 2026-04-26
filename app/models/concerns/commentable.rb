module Commentable
    extend ActiveSupport::Concern
  
    included do
      has_many :tweets, as: :commentable, dependent: :destroy
    end
  end