class RsvpController < ApplicationController
  def show
    code = params[:code]
    @user_group = UserGroup.find_by_code(code)
    respond_to do |format|
      format.html { render :action => :update }
      format.json {
        render :json => {
          :user_group => @user_group,
          :users => @user_group.users.as_json(:except => [:relationship]),
        }
      }
    end
  end

  def update
    code = params[:code]
    @user_group = UserGroup.find_by_code(code)

    respond_to do |format|
      # Saves user_group and users
      if @user_group.update_attributes(params[:user_group])
        format.html
        format.json {
          render :json => {
            :user_group => @user_group,
            :users => @user_group.users.as_json(:except => [:relationship]),
          }
        }
      else
        format.html
        format.json { render :json => { :errors => "Oops, we couldn't update your info" } }
      end
    end
  end
end
