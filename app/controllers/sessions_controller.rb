class SessionsController < ApplicationController
  include ::Role::Constants

  def new
  end

  # POST /sessions
  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.role == ROLE_ADMIN # TODO: make passwords? && user.authenticate(params[:password])
      session[:user_id] = user.id
      respond_to do |format|
        format.json { render :json => { :user_id => user.id } }
        format.html { redirect_to :controller => :users}
      end
    else
      error_message = "Invalid wedding party email"
      flash[:notice] = error_message
      respond_to do |format|
        format.json { render :json => { :errors => error_message } }
        format.html { redirect_to new_session_path }
      end
    end
  end

  def destroy
    session[:user_id] = nil
  end

end
