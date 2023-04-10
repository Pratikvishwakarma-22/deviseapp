
class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user_id: @user.id).or(scope.where(published: true))
      end
    end
  end

  def update?
    user.admin? or ((@record.user_id == @user.id) and not @record.published?)
  end

  def destroy?
    user.admin? or (@record.user_id ==  @user.id)
  end
end
