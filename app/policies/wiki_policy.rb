class WikiPolicy < ApplicationPolicy
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
