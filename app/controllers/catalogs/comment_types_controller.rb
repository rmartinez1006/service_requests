class Catalogs::CommentTypesController < ApplicationController
  # GET /catalogs/comment_types
  # GET /catalogs/comment_types.xml
  layout "catalogs"
  before_filter :authorize
  def index
    @catalogs_comment_types = Catalogs::CommentType.find(:all,:order=>"id ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @catalogs_comment_types }
    end
  end

  # GET /catalogs/comment_types/1
  # GET /catalogs/comment_types/1.xml
  def show
    @catalogs_comment_type = Catalogs::CommentType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @catalogs_comment_type }
    end
  end

  # GET /catalogs/comment_types/new
  # GET /catalogs/comment_types/new.xml
  def new
    @catalogs_comment_type = Catalogs::CommentType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @catalogs_comment_type }
    end
  end

  # GET /catalogs/comment_types/1/edit
  def edit
    @catalogs_comment_type = Catalogs::CommentType.find(params[:id])
  end

  # POST /catalogs/comment_types
  # POST /catalogs/comment_types.xml
  def create
    @catalogs_comment_type = Catalogs::CommentType.new(params[:catalogs_comment_type])

    respond_to do |format|
      if @catalogs_comment_type.save
        format.html { redirect_to(@catalogs_comment_type, :notice => 'Comment type was successfully created.') }
        format.xml  { render :xml => @catalogs_comment_type, :status => :created, :location => @catalogs_comment_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @catalogs_comment_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /catalogs/comment_types/1
  # PUT /catalogs/comment_types/1.xml
  def update
    @catalogs_comment_type = Catalogs::CommentType.find(params[:id])

    respond_to do |format|
      if @catalogs_comment_type.update_attributes(params[:catalogs_comment_type])
        format.html { redirect_to(@catalogs_comment_type, :notice => 'Comment type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @catalogs_comment_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /catalogs/comment_types/1
  # DELETE /catalogs/comment_types/1.xml
  def destroy
    @catalogs_comment_type = Catalogs::CommentType.find(params[:id])
    @catalogs_comment_type.destroy

    respond_to do |format|
      format.html { redirect_to(catalogs_comment_types_url) }
      format.xml  { head :ok }
    end
  end
end
