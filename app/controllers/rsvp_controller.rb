class RsvpController < ApplicationController
  include ::Rsvp::Constants
  def show
    code = params[:code]
    @user_group = UserGroup.find_by_code(code)

    ActiveRecord::Base.include_root_in_json = false

    respond_to do |format|
      format.json {
        render :json => {
          :user_group => @user_group.as_json(:only => USER_GROUP_PUBLIC_READ_FIELDS),
          :users => @user_group.users.as_json(:only => USER_PUBLIC_READ_FIELDS),
          :lodging => lodging_as_json,
        }
      }
    end
  end

  respond_to :json
  def update
    id = params[:id]
    @user_group = UserGroup.find(id)
    user_group_params = params[:user_group]

    user_group_public_write_params = user_group_params.symbolize_keys
      .slice(*USER_GROUP_PUBLIC_WRITE_FIELDS)

    # Saves user_group and users
    if @user_group && @user_group.update_attributes(user_group_public_write_params)
      params[:users] && params[:users].each do |id, attributes|
        user = User.find(id)
        unless user.update_attributes!(attributes.symbolize_keys.slice(*USER_PUBLIC_WRITE_FIELDS))
          Rails.logger.info("ERROR: Failed to update user #{user.id}")
        end
      end
      render :json => {
        :user_group => @user_group.as_json(:only => USER_GROUP_PUBLIC_READ_FIELDS),
        :users => @user_group.users.as_json(:only => USER_PUBLIC_READ_FIELDS),
        :lodging => Lodging
          .where(:room_number => @user_group.room_number)
          .first
          .as_json(:only => LODGING_PUBLIC_READ_FIELDS),
      }
    else
      render :json => { :errors => "Oops, we couldn't update your info" }
    end
  end

  private
  def lodging_as_json
    return {} if @user_group.room_number.blank?

    lodging = Lodging
      .where(:room_number => @user_group.room_number)
      .first
    leader_user = lodging.user

    lodging_json = lodging.as_json(:only => LODGING_PUBLIC_READ_FIELDS)

    if lodging_json.present?
      lodging_json[:roomies] = roomies_as_json
      lodging_json[:leader_user] =
        leader_user.nil? ? {} : leader_user.as_json(:only => USER_PUBLIC_READ_FIELDS)
    end
    lodging_json
  end

  def roomies_as_json
    roomie_user_group = UserGroup.where(:room_number => @user_group.room_number)
    user_group_ids = roomie_user_group.map { |group| group.id }
    User.where(:user_group_id => user_group_ids).as_json(:only => USER_PUBLIC_READ_FIELDS)
  end
end
