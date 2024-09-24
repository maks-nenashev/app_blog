class UserPolicy < ApplicationPolicy
    def create?
      user.admin_role?
    end
  
    def update?
      true#user.admin_role?
    end
  
    def index?
      true#user.admin_role?
    end
  
    def show?
      user.admin_role?
    end
  
    def destroy?
      user.admin_role?
    end
  end