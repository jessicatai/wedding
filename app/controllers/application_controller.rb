class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery

  before_filter :set_current_user_if_possible
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  attr_reader :current_user

  def set_current_user_if_possible
    # TODO(Jessica) fancy remember me cookie-ness
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  private

  def user_not_authorized
    redirect_to :back, :alert => "You don't have permission to those resources."
  end
end
