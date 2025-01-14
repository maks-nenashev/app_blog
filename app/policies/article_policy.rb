class ArticlePolicy < ApplicationPolicy
    def create?
      true#!user.guest?
    end
  
    def update?                                    # guest_user.rb
      true#user.admin_role? || user.moderator_role? || user.author?(record)
    end
  
    def destroy?
      true#user.admin_role? || user.author?(record)
    end
  
    def index?
      true
    end
  
    def show?
      true
    end
  end