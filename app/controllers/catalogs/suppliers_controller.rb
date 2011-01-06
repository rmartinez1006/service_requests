class Catalogs::SuppliersController < ApplicationController
  # GET /catalogs/suppliers
  # GET /catalogs/suppliers.xml
  before_filter :authorize
  layout "catalogs"
  def index
    @catalogs_suppliers = Catalogs::Supplier.all.paginate :page =>params[:page],:per_page=>25, :order => 'created_at ASC'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @catalogs_suppliers }
    end
  end

  # GET /catalogs/suppliers/1
  # GET /catalogs/suppliers/1.xml
  def show
    @catalogs_supplier = Catalogs::Supplier.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @catalogs_supplier }
    end
  end

  # GET /catalogs/suppliers/new
  # GET /catalogs/suppliers/new.xml
  def new
    @catalogs_supplier = Catalogs::Supplier.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @catalogs_supplier }
    end
  end

  # GET /catalogs/suppliers/1/edit
  def edit
    @catalogs_supplier = Catalogs::Supplier.find(params[:id])
  end

  # POST /catalogs/suppliers
  # POST /catalogs/suppliers.xml
  def create
    @catalogs_supplier = Catalogs::Supplier.new(params[:catalogs_supplier])

    respond_to do |format|
      if @catalogs_supplier.save
        format.html { redirect_to(@catalogs_supplier, :notice => 'Supplier was successfully created.') }
        format.xml  { render :xml => @catalogs_supplier, :status => :created, :location => @catalogs_supplier }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @catalogs_supplier.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /catalogs/suppliers/1
  # PUT /catalogs/suppliers/1.xml
  def update
    @catalogs_supplier = Catalogs::Supplier.find(params[:id])

    respond_to do |format|
      if @catalogs_supplier.update_attributes(params[:catalogs_supplier])
        format.html { redirect_to(@catalogs_supplier, :notice => 'Supplier was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @catalogs_supplier.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /catalogs/suppliers/1
  # DELETE /catalogs/suppliers/1.xml
  def destroy
    @catalogs_supplier = Catalogs::Supplier.find(params[:id])
    @catalogs_supplier.destroy

    respond_to do |format|
      format.html { redirect_to(catalogs_suppliers_url) }
      format.xml  { head :ok }
    end
  end
end
