class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery

  before_filter :set_current_user_if_possible
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized



  protected

  attr_reader :current_user

  def set_current_user_if_possible
    Rails.logger.debug("set current user if possible!!!")
    @current_user = nil
    # TODO(Jessica) fancy remember me cookie-ness
  end

  private

  def user_not_authorized
    redirect_to :back, :alert => "You don't have permission to those resources."
  end
end
