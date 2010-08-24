class Administration::UsersController < ApplicationController
  # GET /administration/users
  # GET /administration/users.xml
  def index
    @administration_users = Administration::User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @administration_users }
    end
  end

  # GET /administration/users/1
  # GET /administration/users/1.xml
  def show
    @administration_user = Administration::User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @administration_user }
    end
  end

  # GET /administration/users/new
  # GET /administration/users/new.xml
  def new
    @administration_user = Administration::User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @administration_user }
    end
  end

  # GET /administration/users/1/edit
  def edit
    @administration_user = Administration::User.find(params[:id])
  end

  # POST /administration/users
  # POST /administration/users.xml
  def create
    @administration_user = Administration::User.new(params[:administration_user])

    respond_to do |format|
      if @administration_user.save
        format.html { redirect_to(@administration_user, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @administration_user, :status => :created, :location => @administration_user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @administration_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /administration/users/1
  # PUT /administration/users/1.xml
  def update
    @administration_user = Administration::User.find(params[:id])

    respond_to do |format|
      if @administration_user.update_attributes(params[:administration_user])
        format.html { redirect_to(@administration_user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @administration_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /administration/users/1
  # DELETE /administration/users/1.xml
  def destroy
    @administration_user = Administration::User.find(params[:id])
    @administration_user.destroy

    respond_to do |format|
      format.html { redirect_to(administration_users_url) }
      format.xml  { head :ok }
    end
  end
end
