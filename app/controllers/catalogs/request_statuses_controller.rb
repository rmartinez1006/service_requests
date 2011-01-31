class Catalogs::RequestStatusesController < ApplicationController
  # GET /catalogs/request_statuses
  # GET /catalogs/request_statuses.xml
  before_filter :authorize
  layout "catalogs"
  def index
    @catalogs_request_statuses = Catalogs::RequestStatus.find(:all,:order=>"id ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @catalogs_request_statuses }
    end
  end

  # GET /catalogs/request_statuses/1
  # GET /catalogs/request_statuses/1.xml
  def show
    @catalogs_request_status = Catalogs::RequestStatus.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @catalogs_request_status }
    end
  end

  # GET /catalogs/request_statuses/new
  # GET /catalogs/request_statuses/new.xml
  def new
    @catalogs_request_status = Catalogs::RequestStatus.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @catalogs_request_status }
    end
  end

  # GET /catalogs/request_statuses/1/edit
  def edit
    @catalogs_request_status = Catalogs::RequestStatus.find(params[:id])
  end

  # POST /catalogs/request_statuses
  # POST /catalogs/request_statuses.xml
  def create
    @catalogs_request_status = Catalogs::RequestStatus.new(params[:catalogs_request_status])

    respond_to do |format|
      if @catalogs_request_status.save
        format.html { redirect_to(@catalogs_request_status, :notice => 'Request status was successfully created.') }
        format.xml  { render :xml => @catalogs_request_status, :status => :created, :location => @catalogs_request_status }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @catalogs_request_status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /catalogs/request_statuses/1
  # PUT /catalogs/request_statuses/1.xml
  def update
    @catalogs_request_status = Catalogs::RequestStatus.find(params[:id])

    respond_to do |format|
      if @catalogs_request_status.update_attributes(params[:catalogs_request_status])
        format.html { redirect_to(@catalogs_request_status, :notice => 'Request status was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @catalogs_request_status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /catalogs/request_statuses/1
  # DELETE /catalogs/request_statuses/1.xml
  def destroy
    @catalogs_request_status = Catalogs::RequestStatus.find(params[:id])
    @catalogs_request_status.destroy

    respond_to do |format|
      format.html { redirect_to(catalogs_request_statuses_url) }
      format.xml  { head :ok }
    end
  end
end
