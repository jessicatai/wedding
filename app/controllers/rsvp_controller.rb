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

  def update
    id = params[:id]
    @user_group = UserGroup.find(id)

    # Saves user_group and users
    if @user_group && @user_group.update_attributes(params[:user_group])
      params[:users] && params[:users].each do |id, attributes|
        user = User.find(id)
        unless user.update_attributes!(attributes.except(:id))
          Rails.logger.info("ERROR: Failed to update user #{user.id}")
        end
      end
        render :json => {
          :user_group => @user_group,
          :users => @user_group.users.as_json(:except => [:relationship]),
      }
    else
      format.json { render :json => { :errors => "Oops, we couldn't update your info" } }
    end
  end
end
