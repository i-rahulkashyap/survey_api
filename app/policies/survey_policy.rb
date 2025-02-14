# class SurveyPolicy < ApplicationPolicy
#   # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
#   # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
#   # In most cases the behavior will be identical, but if updating existing
#   # code, beware of possible changes to the ancestors:
#   # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

#   class Scope < ApplicationPolicy::Scope
#     # NOTE: Be explicit about which records you allow access to!
#     # def resolve
#     #   scope.all
#     # end
#   end
# end

class SurveyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end

  def index?
    true
  end

  def show?
    record.user_id == user.id
  end

  def create?
    true
  end

  def update?
    record.user_id == user.id
  end

  def destroy?
    record.user_id == user.id
  end
end