class Requests::ReqDelegationsController < ApplicationController
  # GET /requests/req_delegations
  # GET /requests/req_delegations.xml
  def index
    @requests_req_delegations = Requests::ReqDelegation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @requests_req_delegations }
    end
  end

  # GET /requests/req_delegations/1
  # GET /requests/req_delegations/1.xml
  def show
    @requests_req_delegation = Requests::ReqDelegation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @requests_req_delegation }
    end
  end

  # GET /requests/req_delegations/new
  # GET /requests/req_delegations/new.xml
  def new
    @requests_req_delegation = Requests::ReqDelegation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @requests_req_delegation }
    end
  end

  # GET /requests/req_delegations/1/edit
  def edit
    @requests_req_delegation = Requests::ReqDelegation.find(params[:id])
  end

  # POST /requests/req_delegations
  # POST /requests/req_delegations.xml
  def create
    @requests_req_delegation = Requests::ReqDelegation.new(params[:requests_req_delegation])

    respond_to do |format|
      if @requests_req_delegation.save
        format.html { redirect_to(@requests_req_delegation, :notice => 'Req delegation was successfully created.') }
        format.xml  { render :xml => @requests_req_delegation, :status => :created, :location => @requests_req_delegation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @requests_req_delegation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /requests/req_delegations/1
  # PUT /requests/req_delegations/1.xml
  def update
    @requests_req_delegation = Requests::ReqDelegation.find(params[:id])

    respond_to do |format|
      if @requests_req_delegation.update_attributes(params[:requests_req_delegation])
        format.html { redirect_to(@requests_req_delegation, :notice => 'Req delegation was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @requests_req_delegation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/req_delegations/1
  # DELETE /requests/req_delegations/1.xml
  def destroy
    @requests_req_delegation = Requests::ReqDelegation.find(params[:id])
    @requests_req_delegation.destroy

    respond_to do |format|
      format.html { redirect_to(requests_req_delegations_url) }
      format.xml  { head :ok }
    end
  end
end
