class Catalogs::WorkmanshipsController < ApplicationController
  # GET /catalogs/workmanships
  # GET /catalogs/workmanships.xml
  before_filter :authorize
  layout "catalogs"
  def index
    @catalogs_workmanships = Catalogs::Workmanship.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @catalogs_workmanships }
    end
  end

  # GET /catalogs/workmanships/1
  # GET /catalogs/workmanships/1.xml
  def show
    @catalogs_workmanship = Catalogs::Workmanship.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @catalogs_workmanship }
    end
  end

  # GET /catalogs/workmanships/new
  # GET /catalogs/workmanships/new.xml
  def new
    @catalogs_workmanship = Catalogs::Workmanship.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @catalogs_workmanship }
    end
  end

  # GET /catalogs/workmanships/1/edit
  def edit
    @catalogs_workmanship = Catalogs::Workmanship.find(params[:id])
  end

  # POST /catalogs/workmanships
  # POST /catalogs/workmanships.xml
  def create
    @catalogs_workmanship = Catalogs::Workmanship.new(params[:catalogs_workmanship])

    respond_to do |format|
      if @catalogs_workmanship.save
        format.html { redirect_to(@catalogs_workmanship, :notice => 'Workmanship was successfully created.') }
        format.xml  { render :xml => @catalogs_workmanship, :status => :created, :location => @catalogs_workmanship }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @catalogs_workmanship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /catalogs/workmanships/1
  # PUT /catalogs/workmanships/1.xml
  def update
    @catalogs_workmanship = Catalogs::Workmanship.find(params[:id])

    respond_to do |format|
      if @catalogs_workmanship.update_attributes(params[:catalogs_workmanship])
        format.html { redirect_to(@catalogs_workmanship, :notice => 'Workmanship was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @catalogs_workmanship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /catalogs/workmanships/1
  # DELETE /catalogs/workmanships/1.xml
  def destroy
    @catalogs_workmanship = Catalogs::Workmanship.find(params[:id])
    @catalogs_workmanship.destroy

    respond_to do |format|
      format.html { redirect_to(catalogs_workmanships_url) }
      format.xml  { head :ok }
    end
  end
end
