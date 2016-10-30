class UserPolicy < ApplicationPolicy
  include ::Role::Constants

  def destroy?
    user && user_admin?(user.role)
  end

  def create?
    user && user_admin?(user.role)
  end

  def show?
    user && user_admin?(user.role)
  end

  private
  def user_admin?(role)
    [ROLE_ADMIN, ROLE_INVITE_ADMIN].include?(role)
  end
end
