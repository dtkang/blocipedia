class WikiPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      wikis = scope.where(private: false)
      if user.admin?
        wikis = scope.all
      elsif user.premium?
        premium_private_wikis = scope.where({private: true, user_id: user.id})
        premium_private_wikis.each do |wiki|
          wikis.create(:title => wiki.title, :body => wiki.body, :private => wiki.private)
        end
      elsif user.standard?
        #add wikis user is collaborating on
      end
      wikis
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
