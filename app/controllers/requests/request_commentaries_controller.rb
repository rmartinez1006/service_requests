class Requests::RequestCommentariesController < ApplicationController
  # GET /requests/request_commentaries
  # GET /requests/request_commentaries.xml
  before_filter :authorize
  def index
    @requests_request_commentaries = Requests::RequestCommentary.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @requests_request_commentaries }
    end
  end

  # GET /requests/request_commentaries/1
  # GET /requests/request_commentaries/1.xml
  def show
    @requests_request_commentary = Requests::RequestCommentary.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @requests_request_commentary }
    end
  end

  # GET /requests/request_commentaries/new
  # GET /requests/request_commentaries/new.xml
  def new
    @requests_request_commentary = Requests::RequestCommentary.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @requests_request_commentary }
    end
  end

  # GET /requests/request_commentaries/1/edit
  def edit
    @requests_request_commentary = Requests::RequestCommentary.find(params[:id])
  end

  # POST /requests/request_commentaries
  # POST /requests/request_commentaries.xml
  def create
    @requests_request_commentary = Requests::RequestCommentary.new(params[:requests_request_commentary])

    respond_to do |format|
      if @requests_request_commentary.save
        format.html { redirect_to(@requests_request_commentary, :notice => 'Request commentary was successfully created.') }
        format.xml  { render :xml => @requests_request_commentary, :status => :created, :location => @requests_request_commentary }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @requests_request_commentary.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /requests/request_commentaries/1
  # PUT /requests/request_commentaries/1.xml
  def update
    @requests_request_commentary = Requests::RequestCommentary.find(params[:id])

    respond_to do |format|
      if @requests_request_commentary.update_attributes(params[:requests_request_commentary])
        format.html { redirect_to(@requests_request_commentary, :notice => 'Request commentary was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @requests_request_commentary.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/request_commentaries/1
  # DELETE /requests/request_commentaries/1.xml
  def destroy
    @requests_request_commentary = Requests::RequestCommentary.find(params[:id])
    @requests_request_commentary.destroy

    respond_to do |format|
      format.html { redirect_to(requests_request_commentaries_url) }
      format.xml  { head :ok }
    end
  end
end
