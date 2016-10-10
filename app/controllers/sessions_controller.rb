class SessionsController < ApplicationController
  def new
  end

  # POST /sessions
  def create
    user = User.find_by_email(params[:session][:email])
    if user # TODO: make passwords? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to :controller => :users
    else
     flash[:notice] = "Invalid wedding party email"
     redirect_to new_session_path
    end
  end

  def destroy
    session[:user_id] = nil
  end

end
