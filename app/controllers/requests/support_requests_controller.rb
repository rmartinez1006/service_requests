class Requests::SupportRequestsController < ApplicationController
  # GET /requests/support_requests
  # GET /requests/support_requests.xml
  def index
    @requests_support_requests = Requests::SupportRequest.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @requests_support_requests }
    end
  end

  # GET /requests/support_requests/1
  # GET /requests/support_requests/1.xml
  def show
    @requests_support_request = Requests::SupportRequest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @requests_support_request }
    end
  end

  # GET /requests/support_requests/new
  # GET /requests/support_requests/new.xml
  def new
    @requests_support_request = Requests::SupportRequest.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @requests_support_request }
    end
  end

  # GET /requests/support_requests/1/edit
  def edit
    @requests_support_request = Requests::SupportRequest.find(params[:id])
  end

  # POST /requests/support_requests
  # POST /requests/support_requests.xml
  def create
    @requests_support_request = Requests::SupportRequest.new(params[:requests_support_request])

    respond_to do |format|
      if @requests_support_request.save
        format.html { redirect_to(@requests_support_request, :notice => 'Support request was successfully created.') }
        format.xml  { render :xml => @requests_support_request, :status => :created, :location => @requests_support_request }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @requests_support_request.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /requests/support_requests/1
  # PUT /requests/support_requests/1.xml
  def update
    @requests_support_request = Requests::SupportRequest.find(params[:id])

    respond_to do |format|
      if @requests_support_request.update_attributes(params[:requests_support_request])
        format.html { redirect_to(@requests_support_request, :notice => 'Support request was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @requests_support_request.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/support_requests/1
  # DELETE /requests/support_requests/1.xml
  def destroy
    @requests_support_request = Requests::SupportRequest.find(params[:id])
    @requests_support_request.destroy

    respond_to do |format|
      format.html { redirect_to(requests_support_requests_url) }
      format.xml  { head :ok }
    end
  end
end
