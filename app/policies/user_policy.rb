class UserPolicy < ApplicationPolicy
  def destroy?
    user && (user.role?(:admin) || record.id == user.id)
  end

  def create?
    user && (user.role?(:admin) || record.id == user.id)
  end
end
