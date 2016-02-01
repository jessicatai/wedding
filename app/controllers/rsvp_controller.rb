class RsvpController < ApplicationController
  def update
    code = params[:group_code]
    @user_group = UserGroup.find_by_code(code)
    respond_to do |format|
      format.html
      format.json { render :json => @user_group.users }
    end
  end
end
