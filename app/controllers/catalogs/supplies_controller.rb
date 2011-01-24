class Catalogs::SuppliesController < ApplicationController
  # GET /catalogs/supplies
  # GET /catalogs/supplies.xml
  before_filter :authorize
  layout "catalogs"
  def index
    # Materiales
    @catalogs_supplies = Catalogs::Supply.find(:all,  :conditions => "type_supply = 1").paginate :page =>params[:page],:per_page=>11, :order => 'created_at DESC'
    # Mano de Obra
    @catalogs_workmanship = Catalogs::Supply.find(:all,  :conditions => "type_supply = 2").paginate :page =>params[:page],:per_page=>11, :order => 'created_at DESC'


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @catalogs_supplies }
      format.xml  { render :xml => @catalogs_workmanship }
    end
  end

  # GET /catalogs/supplies/1
  # GET /catalogs/supplies/1.xml
  def show
    @catalogs_supply = Catalogs::Supply.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @catalogs_supply }
    end
  end

  # GET /catalogs/supplies/new
  # GET /catalogs/supplies/new.xml
  def new
    @catalogs_supply = Catalogs::Supply.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @catalogs_supply }
    end
  end

  # GET /catalogs/supplies/1/edit
  def edit
    @catalogs_supply = Catalogs::Supply.find(params[:id])
  end

  # POST /catalogs/supplies
  # POST /catalogs/supplies.xml
  def create
    @catalogs_supply = Catalogs::Supply.new(params[:catalogs_supply])

    respond_to do |format|
      if @catalogs_supply.save
        format.html { redirect_to(@catalogs_supply, :notice => 'Supply was successfully created.') }
        format.xml  { render :xml => @catalogs_supply, :status => :created, :location => @catalogs_supply }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @catalogs_supply.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /catalogs/supplies/1
  # PUT /catalogs/supplies/1.xml
  def update
    @catalogs_supply = Catalogs::Supply.find(params[:id])

    respond_to do |format|
      if @catalogs_supply.update_attributes(params[:catalogs_supply])
        format.html { redirect_to(@catalogs_supply, :notice => 'Supply was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @catalogs_supply.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /catalogs/supplies/1
  # DELETE /catalogs/supplies/1.xml
  def destroy
    @catalogs_supply = Catalogs::Supply.find(params[:id])
    @catalogs_supply.destroy

    respond_to do |format|
      format.html { redirect_to(catalogs_supplies_url) }
      format.xml  { head :ok }
    end
  end
end
