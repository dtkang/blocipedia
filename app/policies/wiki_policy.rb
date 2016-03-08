class WikiPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin? || user.premium?
        scope.all
      else
        scope.where(private: false)
      end
    end
  end
  
  def edit?
    update?
  end
  
  def update?
    user.admin? || record.user == user
  end
  
  def destroy?
    update?
  end
  
  def create?
    true
  end
end
