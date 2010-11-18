class RequestsAdministration::DelegationsController < ApplicationController
  # GET /requests/delegations
  # GET /requests/delegations.xml
  before_filter :authorize
  def index
    @requests_administration_delegations = RequestsAdministration::Delegation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @requests_administration_delegations }
    end
  end

  # GET /requests/delegations/1
  # GET /requests/delegations/1.xml
  def show
    @requests_administration_delegation = RequestsAdministration::Delegation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @requests_administration_delegation }
    end
  end

  # GET /requests/delegations/new
  # GET /requests/delegations/new.xml
  def new
     @requests_administration_delegation = RequestsAdministration::Delegation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @requests_administration_delegation }
    end
  end

  # GET /requests/delegations/1/edit
  def edit
    @requests_administration_delegation = RequestsAdministration::Delegation.find(params[:id])
  end

  # POST /requests/delegations
  # POST /requests/delegations.xml
  def create
    @requests_administration_delegation = RequestsAdministration::Delegation.new(params[:requests_req_delegation])

    respond_to do |format|
      if @requests_administration_delegation.save
        format.html { redirect_to(@requests_administration_delegation, :notice => 'Req delegation was successfully created.') }
        format.xml  { render :xml => @requests_administration_delegation, :status => :created, :location => @requests_administration_delegation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @requests_administration_delegation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /requests/delegations/1
  # PUT /requests/delegations/1.xml
  def update
    @requests_administration_delegation = Requests::Delegation.find(params[:id])

    respond_to do |format|
      if @requests_administration_delegation.update_attributes(params[:requests_req_delegation])
        format.html { redirect_to(@requests_administration_delegation, :notice => 'Req delegation was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @requests_administration_delegation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/delegations/1
  # DELETE /requests/delegations/1.xml
  def destroy
    @requests_administration_delegation = Requests::Delegation.find(params[:id])
    @requests_administration_delegation.destroy

    respond_to do |format|
      format.html { redirect_to(requests_delegations_url) }
      format.xml  { head :ok }
    end
  end
end
