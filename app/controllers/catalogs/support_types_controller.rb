class Catalogs::SupportTypesController < ApplicationController
  layout "catalogs"
  # GET /catalogs/support_types
  # GET /catalogs/support_types.xml
  def index
    @catalogs_support_types = Catalogs::SupportType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @catalogs_support_types }
    end
  end

  # GET /catalogs/support_types/1
  # GET /catalogs/support_types/1.xml
  def show
    @catalogs_support_type = Catalogs::SupportType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @catalogs_support_type }
    end
  end

  # GET /catalogs/support_types/new
  # GET /catalogs/support_types/new.xml
  def new
    @catalogs_support_type = Catalogs::SupportType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @catalogs_support_type }
    end
  end

  # GET /catalogs/support_types/1/edit
  def edit
    @catalogs_support_type = Catalogs::SupportType.find(params[:id])
  end

  # POST /catalogs/support_types
  # POST /catalogs/support_types.xml
  def create
    @catalogs_support_type = Catalogs::SupportType.new(params[:catalogs_support_type])

    respond_to do |format|
      if @catalogs_support_type.save
        format.html { redirect_to(@catalogs_support_type, :notice => 'Support type was successfully created.') }
        format.xml  { render :xml => @catalogs_support_type, :status => :created, :location => @catalogs_support_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @catalogs_support_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /catalogs/support_types/1
  # PUT /catalogs/support_types/1.xml
  def update
    @catalogs_support_type = Catalogs::SupportType.find(params[:id])

    respond_to do |format|
      if @catalogs_support_type.update_attributes(params[:catalogs_support_type])
        format.html { redirect_to(@catalogs_support_type, :notice => 'Support type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @catalogs_support_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /catalogs/support_types/1
  # DELETE /catalogs/support_types/1.xml
  def destroy
    @catalogs_support_type = Catalogs::SupportType.find(params[:id])
    @catalogs_support_type.destroy

    respond_to do |format|
      format.html { redirect_to(catalogs_support_types_url) }
      format.xml  { head :ok }
    end
  end
end
