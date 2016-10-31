class RsvpController < ApplicationController
  def show
    code = params[:code]
    @user_group = UserGroup.find_by_code(code)

    ActiveRecord::Base.include_root_in_json = false

    respond_to do |format|
      # format.html { render :action => :update }
      format.json {
        render :json => {
          :user_group => @user_group,
          :users => @user_group.users.as_json(:except => [:relationship]),
        }
      }
    end
  end
end
