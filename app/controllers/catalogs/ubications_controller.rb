class Catalogs::UbicationsController < ApplicationController
  before_filter :authorize
  layout "catalogs"
  # GET /catalogs/ubications
  # GET /catalogs/ubications.xml
  def index
    @catalogs_ubications = Catalogs::Ubication.order(:unit_id, :abbr).all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @catalogs_ubications }
    end
  end

  # GET /catalogs/ubications/1
  # GET /catalogs/ubications/1.xml
  def show
    @catalogs_ubication = Catalogs::Ubication.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @catalogs_ubication }
    end
  end

  # GET /catalogs/ubications/new
  # GET /catalogs/ubications/new.xml
  def new
    @catalogs_ubication = Catalogs::Ubication.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @catalogs_ubication }
    end
  end

  # GET /catalogs/ubications/1/edit
  def edit
    @catalogs_ubication = Catalogs::Ubication.find(params[:id])
  end

  # POST /catalogs/ubications
  # POST /catalogs/ubications.xml
  def create
    @catalogs_ubication = Catalogs::Ubication.new(params[:catalogs_ubication])

    respond_to do |format|
      if @catalogs_ubication.save
        format.html { redirect_to(@catalogs_ubication, :notice => 'Ubication was successfully created.') }
        format.xml  { render :xml => @catalogs_ubication, :status => :created, :location => @catalogs_ubication }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @catalogs_ubication.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /catalogs/ubications/1
  # PUT /catalogs/ubications/1.xml
  def update
    @catalogs_ubication = Catalogs::Ubication.find(params[:id])

    respond_to do |format|
      if @catalogs_ubication.update_attributes(params[:catalogs_ubication])
        format.html { redirect_to(@catalogs_ubication, :notice => 'Ubication was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @catalogs_ubication.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /catalogs/ubications/1
  # DELETE /catalogs/ubications/1.xml
  def destroy
    @catalogs_ubication = Catalogs::Ubication.find(params[:id])
    @catalogs_ubication.destroy

    respond_to do |format|
      format.html { redirect_to(catalogs_ubications_url) }
      format.xml  { head :ok }
    end
  end
end
