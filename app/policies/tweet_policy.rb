class TweetPolicy < ApplicationPolicy
    def create?
        !user.guest?
    end
  
    def update?                                    # guest_user.rb
      user.admin_role? || user.moderator_role? || user.author?(record)
    end
  
    def destroy?
      user.admin_role? || user.author?(record)
    end
  
    def index?
      true
    end
  
    def show?
      true
    end
  end