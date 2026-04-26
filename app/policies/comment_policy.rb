class CommentPolicy < ApplicationPolicy
    def create?
        !user.guest?
    end
  
    def update?                                    # guest_user.rb
      user.admin_role? || user.moderator_role? || user.author?(record)
    end
  
    def destroy?
      user.admin_role? || user.author?(record)
    end
  
    def new?
       true#user.author?(record) # или user.admin? и т.д.
    end
    
    def index?
      true
    end
  
    def show?
      true
    end
  end