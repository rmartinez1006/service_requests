class Administration::UserRolesController < ApplicationController
  # GET /administration/user_roles
  # GET /administration/user_roles.xml
  before_filter :authorize
  layout "administration"

  
  def index

    if lv_role = Administration::UserSession.find.record.attributes['role']!= 'ADMIN'
      redirect_to administration_users_path
      return
    end
    @administration_user_roles = Administration::UserRole.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @administration_user_roles }
    end
  end

  # GET /administration/user_roles/1
  # GET /administration/user_roles/1.xml
  def show
    @administration_user_role = Administration::UserRole.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @administration_user_role }
    end
  end

  # GET /administration/user_roles/new
  # GET /administration/user_roles/new.xml
  def new
    @administration_user_role = Administration::UserRole.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @administration_user_role }
    end
  end

  # GET /administration/user_roles/1/edit
  def edit
    @administration_user_role = Administration::UserRole.find(params[:id])
  end

  # POST /administration/user_roles
  # POST /administration/user_roles.xml
  def create
    @administration_user_role = Administration::UserRole.new(params[:administration_user_role])

    respond_to do |format|
      if @administration_user_role.save
        format.html { redirect_to(@administration_user_role, :notice => 'User role was successfully created.') }
        format.xml  { render :xml => @administration_user_role, :status => :created, :location => @administration_user_role }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @administration_user_role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /administration/user_roles/1
  # PUT /administration/user_roles/1.xml
  def update
    @administration_user_role = Administration::UserRole.find(params[:id])

    respond_to do |format|
      if @administration_user_role.update_attributes(params[:administration_user_role])
        format.html { redirect_to(@administration_user_role, :notice => 'User role was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @administration_user_role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /administration/user_roles/1
  # DELETE /administration/user_roles/1.xml
  def destroy
    @administration_user_role = Administration::UserRole.find(params[:id])
    @administration_user_role.destroy

    respond_to do |format|
      format.html { redirect_to(administration_user_roles_url) }
      format.xml  { head :ok }
    end
  end
end
