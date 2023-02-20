module Commentable
    extend ActiveSupport::Concern
  
    included do
      has_many :commits, as: :commentable, dependent: :destroy
    end
  end