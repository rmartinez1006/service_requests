class Catalogs::UnitsController < ApplicationController
  before_filter :authorize
  layout "catalogs"
  # GET /catalogs/units
  # GET /catalogs/units.xml
  def index
    if lv_role = Administration::UserSession.find.record.attributes['role']!= 'ADMIN'
      redirect_to administration_users_path
      return
    end
    @catalogs_units = Catalogs::Unit.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @catalogs_units }
    end
  end

  # GET /catalogs/units/1
  # GET /catalogs/units/1.xml
  def show
    @catalogs_unit = Catalogs::Unit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @catalogs_unit }
    end
  end

  # GET /catalogs/units/new
  # GET /catalogs/units/new.xml
  def new
    @catalogs_unit = Catalogs::Unit.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @catalogs_unit }
    end
  end

  # GET /catalogs/units/1/edit
  def edit
    @catalogs_unit = Catalogs::Unit.find(params[:id])
  end

  # POST /catalogs/units
  # POST /catalogs/units.xml
  def create
    @catalogs_unit = Catalogs::Unit.new(params[:catalogs_unit])

    respond_to do |format|
      if @catalogs_unit.save
        format.html { redirect_to(@catalogs_unit, :notice => 'Unit was successfully created.') }
        format.xml  { render :xml => @catalogs_unit, :status => :created, :location => @catalogs_unit }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @catalogs_unit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /catalogs/units/1
  # PUT /catalogs/units/1.xml
  def update
    @catalogs_unit = Catalogs::Unit.find(params[:id])

    respond_to do |format|
      if @catalogs_unit.update_attributes(params[:catalogs_unit])
        format.html { redirect_to(@catalogs_unit, :notice => 'Unit was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @catalogs_unit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /catalogs/units/1
  # DELETE /catalogs/units/1.xml
  def destroy
    @catalogs_unit = Catalogs::Unit.find(params[:id])
    @catalogs_unit.destroy

    respond_to do |format|
      format.html { redirect_to(catalogs_units_url) }
      format.xml  { head :ok }
    end
  end
end
