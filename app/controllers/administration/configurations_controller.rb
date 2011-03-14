class Administration::ConfigurationsController < ApplicationController
  # GET /administration/configurations
  # GET /administration/configurations.xml
  def index
    @administration_configurations = Administration::Configuration.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @administration_configurations }
    end
  end

  # GET /administration/configurations/1
  # GET /administration/configurations/1.xml
  def show
    @administration_configuration = Administration::Configuration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @administration_configuration }
    end
  end

  # GET /administration/configurations/new
  # GET /administration/configurations/new.xml
  def new
    @administration_configuration = Administration::Configuration.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @administration_configuration }
    end
  end

  # GET /administration/configurations/1/edit
  def edit
    @administration_configuration = Administration::Configuration.find(params[:id])
  end

  # POST /administration/configurations
  # POST /administration/configurations.xml
  def create
    @administration_configuration = Administration::Configuration.new(params[:administration_configuration])

    respond_to do |format|
      if @administration_configuration.save
        format.html { redirect_to(@administration_configuration, :notice => 'Configuration was successfully created.') }
        format.xml  { render :xml => @administration_configuration, :status => :created, :location => @administration_configuration }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @administration_configuration.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /administration/configurations/1
  # PUT /administration/configurations/1.xml
  def update
    @administration_configuration = Administration::Configuration.find(params[:id])

    respond_to do |format|
      if @administration_configuration.update_attributes(params[:administration_configuration])
        format.html { redirect_to(@administration_configuration, :notice => 'Configuration was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @administration_configuration.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /administration/configurations/1
  # DELETE /administration/configurations/1.xml
  def destroy
    @administration_configuration = Administration::Configuration.find(params[:id])
    @administration_configuration.destroy

    respond_to do |format|
      format.html { redirect_to(administration_configurations_url) }
      format.xml  { head :ok }
    end
  end
end
