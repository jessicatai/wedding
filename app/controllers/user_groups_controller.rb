class UserGroupsController < ApplicationController
  # GET /user_groups
  # GET /user_groups.xml
  def index
    @user_groups = UserGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_groups }
    end
  end

  # GET /user_groups/1
  # GET /user_groups/1.xml
  def show
    @user_group = UserGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @user_group }
    end
  end

  # GET /user_groups/new
  # GET /user_groups/new.xml
  def new
    @user_group = UserGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_group }
    end
  end

  # GET /user_groups/1/edit
  def edit
    @user_group = UserGroup.find(params[:id])
  end

  # POST /user_groups
  # POST /user_groups.xml
  def create
    @user_group = UserGroup.new(params[:user_group])

    respond_to do |format|
      if @user_group.save
        format.html { redirect_to(@user_group, :notice => 'User group was successfully created.') }
        format.xml  { render :xml => @user_group, :status => :created, :location => @user_group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user_groups/1
  # PUT /user_groups/1.json
  def update
    id = params[:id]
    @user_group = UserGroup.find(id)

    respond_to do |format|
      # Saves user_group and users
      if @user_group && @user_group.update_attributes(params[:user_group])
        params[:users] && params[:users].each do |id, attributes|
          user = User.find(id)
          unless user.update_attributes!(attributes.except(:id))
            Rails.logger.error("failed to update user #{user.id}")
          end
        end
        format.html { render :controller => :rsvp, :action => :show, :code => @user_group.code }
        format.json {
          render :json => {
            :user_group => @user_group,
            :users => @user_group.users.as_json(:except => [:relationship]),
          }
        }
      else
        format.html { redirect_to "/rsvp" }
        format.json { render :json => { :errors => "Oops, we couldn't update your info" } }
      end
    end
  end

  # DELETE /user_groups/1
  # DELETE /user_groups/1.xml
  def destroy
    @user_group = UserGroup.find(params[:id])
    @user_group.destroy

    respond_to do |format|
      format.html { redirect_to(user_groups_url) }
      format.xml  { head :ok }
    end
  end
end
