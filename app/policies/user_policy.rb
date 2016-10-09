class UserPolicy < ApplicationPolicy
  include ::Role::Constants

  def destroy?
    user && user_admin(user.role)
  end

  def create?
    Rails.logger.debug("create??? #{user}, #{record}, #{user && user_admin?(user.role)} <- value")
    user && user_admin?(user.role)
  end

  private
  def user_admin?(role)
    Rails.logger.debug("role admin #{ROLE_ADMIN}, role #{role}, #{[ROLE_ADMIN, ROLE_INVITE_ADMIN].include?(role)} <-- return value")
    [ROLE_ADMIN, ROLE_INVITE_ADMIN].include?(role)
  end
end
