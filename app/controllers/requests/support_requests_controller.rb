class Requests::SupportRequestsController < ApplicationController
  # GET /requests/support_requests
  # GET /requests/support_requests.xml
  before_filter :authorize
  layout "requests"

  def index
    #@requests_support_requests = Requests::SupportRequest.all
    #@requests_support_requests = Requests::SupportRequest.find(:all, :conditions => 'ubication_id = 1' )    
     user_ubication_id= Administration::UserSession.find.record.attributes['ubication_id']
     @ubication_id = Catalogs::Ubication.find(user_ubication_id)
     unit_id =  @ubication_id.unit_id
#    Usuario
     user_id = Administration::UserSession.find.record.attributes['id']


     lv_sql ="SELECT r.* FROM requests_support_requests as r
               INNER JOIN catalogs_ubications as c ON
                 c.id = r.ubication_id
               INNER JOIN catalogs_units as u ON
                 u.id = r.ubication_id
               WHERE u.id = ".concat(unit_id.to_s) +
              " UNION
                SELECT r.* FROM requests_support_requests as r
                 WHERE r.helper_id = ".concat(user_id.to_s)
    
    @requests_support_requests = Requests::SupportRequest.find_by_sql(lv_sql)
    
#   Solicitudes en la que esta involucrado
     lv_sql ="SELECT DISTINCT s.*
                FROM requests_support_requests as s
              INNER JOIN requests_req_delegations as r
                  ON s.id = r.request_id
               WHERE s.helper_id <> r.helper_id
                 AND r.helper_id = ".concat(user_id.to_s)

    @requests_support_requests_deleg = Requests::SupportRequest.find_by_sql(lv_sql)




    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @requests_support_requests }
      format.xml  { render :xml => @requests_support_requests_deleg }
    end
  end

  # GET /requests/support_requests/1
  # GET /requests/support_requests/1.xml
  def show
    @requests_support_request = Requests::SupportRequest.find(params[:id])
#   Mostrar Comentarios
    @requests_request_commentaries = Requests::RequestCommentary.find( :all, :conditions => ['"request_id" = ?', params[:id]] )

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @requests_support_request }
      format.xml  { render :xml => @requests_request_commentaries }
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

  # GET /requests/support_requests/1/scale
  def scale
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
#   usuario (autentificado)
    user_id = Administration::UserSession.find.record.attributes['id']

#   Agregar comentario durante resolución
    if params.keys[0] == 'comment'

        @catalogs_comment_types = Catalogs::CommentType.find(:first, :conditions => "abbr = 'RESOL'")
        

        
        request_commentary = Requests::RequestCommentary.new
        request_commentary.request_id =  @requests_support_request.id
        request_commentary.user_id = user_id
        request_commentary.commentaries = @requests_support_request.commentaries_to_add
        request_commentary.comment_type_id = @catalogs_comment_types.id
        request_commentary.save

    end

#   Guardar movimientos de escalado de solicitud
    if params.keys[0] == 'commit'
       if @requests_support_request.helper_id != nil          
          requests_req_delegation = Requests::ReqDelegation.new
          requests_req_delegation.request_id = @requests_support_request.id
          requests_req_delegation.user_id = user_id
          requests_req_delegation.helper_id = @requests_support_request.helper_id
          requests_req_delegation.notify = @requests_support_request.notify
          requests_req_delegation.save
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
