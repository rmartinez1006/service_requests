class Administration::UserHierachiesController < ApplicationController
  # GET /administration/user_hierachies
  # GET /administration/user_hierachies.xml
  before_filter :authorize
  layout "administration"
  def index
    if lv_role = Administration::UserSession.find.record.attributes['role']!= 'ADMIN'
      redirect_to administration_users_path
      return
    end    
    @administration_user_hierachies = Administration::UserHierachy.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @administration_user_hierachies }
    end
  end

  # GET /administration/user_hierachies/1
  # GET /administration/user_hierachies/1.xml
  def show
    @administration_user_hierachy = Administration::UserHierachy.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @administration_user_hierachy }
    end
  end

  # GET /administration/user_hierachies/new
  # GET /administration/user_hierachies/new.xml
  def new
    @administration_user_hierachy = Administration::UserHierachy.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @administration_user_hierachy }
    end
  end

  # GET /administration/user_hierachies/1/edit
  def edit
    @administration_user_hierachy = Administration::UserHierachy.find(params[:id])
  end

  # POST /administration/user_hierachies
  # POST /administration/user_hierachies.xml
  def create
    @administration_user_hierachy = Administration::UserHierachy.new(params[:administration_user_hierachy])

    respond_to do |format|
      if @administration_user_hierachy.save
        format.html { redirect_to(@administration_user_hierachy, :notice => 'User hierachy was successfully created.') }
        format.xml  { render :xml => @administration_user_hierachy, :status => :created, :location => @administration_user_hierachy }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @administration_user_hierachy.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /administration/user_hierachies/1
  # PUT /administration/user_hierachies/1.xml
  def update
    @administration_user_hierachy = Administration::UserHierachy.find(params[:id])

    respond_to do |format|
      if @administration_user_hierachy.update_attributes(params[:administration_user_hierachy])
        format.html { redirect_to(@administration_user_hierachy, :notice => 'User hierachy was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @administration_user_hierachy.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /administration/user_hierachies/1
  # DELETE /administration/user_hierachies/1.xml
  def destroy
    @administration_user_hierachy = Administration::UserHierachy.find(params[:id])
    @administration_user_hierachy.destroy

    respond_to do |format|
      format.html { redirect_to(administration_user_hierachies_url) }
      format.xml  { head :ok }
    end
  end
end
