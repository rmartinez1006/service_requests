class Catalogs::PrioritiesController < ApplicationController
  # GET /catalogs/priorities
  # GET /catalogs/priorities.xml
  layout "catalogs"
  def index
    @catalogs_priorities = Catalogs::Priority.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @catalogs_priorities }
    end
  end

  # GET /catalogs/priorities/1
  # GET /catalogs/priorities/1.xml
  def show
    @catalogs_priority = Catalogs::Priority.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @catalogs_priority }
    end
  end

  # GET /catalogs/priorities/new
  # GET /catalogs/priorities/new.xml
  def new
    @catalogs_priority = Catalogs::Priority.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @catalogs_priority }
    end
  end

  # GET /catalogs/priorities/1/edit
  def edit
    @catalogs_priority = Catalogs::Priority.find(params[:id])
  end

  # POST /catalogs/priorities
  # POST /catalogs/priorities.xml
  def create
    @catalogs_priority = Catalogs::Priority.new(params[:catalogs_priority])

    respond_to do |format|
      if @catalogs_priority.save
        format.html { redirect_to(@catalogs_priority, :notice => 'Priority was successfully created.') }
        format.xml  { render :xml => @catalogs_priority, :status => :created, :location => @catalogs_priority }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @catalogs_priority.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /catalogs/priorities/1
  # PUT /catalogs/priorities/1.xml
  def update
    @catalogs_priority = Catalogs::Priority.find(params[:id])

    respond_to do |format|
      if @catalogs_priority.update_attributes(params[:catalogs_priority])
        format.html { redirect_to(@catalogs_priority, :notice => 'Priority was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @catalogs_priority.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /catalogs/priorities/1
  # DELETE /catalogs/priorities/1.xml
  def destroy
    @catalogs_priority = Catalogs::Priority.find(params[:id])
    @catalogs_priority.destroy

    respond_to do |format|
      format.html { redirect_to(catalogs_priorities_url) }
      format.xml  { head :ok }
    end
  end
end
