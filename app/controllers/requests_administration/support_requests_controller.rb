class RequestsAdministration::SupportRequestsController < ApplicationController
  # GET /requests/request_support_requests
  # GET /requests/request_support_requests.xml
  #include Common
  include Common

  
  
  before_filter :authorize
  layout "requests"


  def index
    #@request_support_requests = Requests::SupportRequest.all
    #@request_support_requests = Requests::SupportRequest.find(:all, :conditions => 'ubication_id = 1' )
     user_ubication_id= Administration::UserSession.find.record.attributes['ubication_id']
     @ubication_id = Catalogs::Ubication.find(user_ubication_id)
     unit_id =  @ubication_id.unit_id
#    Usuario
     user_id = Administration::UserSession.find.record.attributes['id']

     role = Administration::UserSession.find.record.attributes['role']
    if role=='ADMIN'
       lv_sql ="SELECT r.* FROM request_support_requests as r
                 INNER JOIN catalogs_ubications as c ON
                  c.id = r.ubication_id
                 INNER JOIN catalogs_units as u ON
                   u.id = c.unit_id
                ORDER BY created_at DESC"

    else
     lv_sql ="SELECT r.* FROM request_support_requests as r
               INNER JOIN catalogs_ubications as c ON
                 c.id = r.ubication_id
               INNER JOIN catalogs_units as u ON
                 u.id = c.unit_id
               WHERE u.id = ".concat(unit_id.to_s) +
              " UNION
                SELECT r.* FROM request_support_requests as r
                 WHERE r.helper_id = ".concat(user_id.to_s)+
              "ORDER BY created_at DESC"
  
    end
    @requests_administration_support_requests = RequestsAdministration::SupportRequest.find_by_sql(lv_sql).paginate :page =>params[:page],:per_page=>9, :order => 'created_at DESC'

#   Solicitudes en la que esta involucrado
     lv_sql ="SELECT DISTINCT s.*
                FROM request_support_requests as s
              INNER JOIN request_delegations as r
                  ON s.id = r.support_request_id
               WHERE s.helper_id <> r.helper_id
                 AND r.helper_id = ".concat(user_id.to_s)+
               "ORDER BY created_at DESC"

    @requests_administration_support_requests_deleg = RequestsAdministration::SupportRequest.find_by_sql(lv_sql).paginate :page =>params[:page],:per_page=>4, :order => 'created_at DESC'


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @requests_administration_support_requests }
      format.xml  { render :xml => @requests_administration_support_requests_deleg }
    end
  end

  # GET /requests/request_support_requests/1
  # GET /requests/request_support_requests/1.xml
  def show
    @requests_support_request = RequestsAdministration::SupportRequest.find(params[:id])
    # Mostrar Comentarios
    lv_sql ="SELECT * FROM request_commentaries
              WHERE support_request_id = " + params[:id] +
            " AND comment_type_id IN
                (SELECT id FROM catalogs_comment_types
                 WHERE abbr IN ('RESOL','AUT-P02','AUT-P03','AUT-P04','AUT-P05'))
              ORDER BY created_at DESC"
    
  #@requests_request_commentaries = Requests::RequestCommentary.find( :all, :conditions params[:id]=> ['"support_request_id" = ?', params[:id]] )
    @requests_request_commentaries = RequestsAdministration::Commentary.find_by_sql(lv_sql).paginate :page =>params[:page],:per_page=>4, :order => 'created_at ASC'

    # Ubicación Fisica del problema (Tabla de cometarios)
    lv_sql ="SELECT DISTINCT * FROM request_commentaries
              WHERE support_request_id = " + params[:id] +
            " AND comment_type_id IN
                (SELECT id FROM catalogs_comment_types
                 WHERE abbr IN ('UBICA'))"  
    @requests_request_req_ubication = RequestsAdministration::Commentary.find_by_sql(lv_sql)
    if @requests_request_req_ubication.size > 0
       @requests_support_request.req_ubication = @requests_request_req_ubication[0].commentaries       
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @requests_support_request }
      
      format.xml  { render :xml => @requests_request_commentaries }
      format.xml  { render :xml => @requests_request_req_ubication }
    end
  end

  # GET /requests/request_support_requests/new
  # GET /requests/request_support_requests/new.xml
  def new
    @requests_support_request = RequestsAdministration::SupportRequest.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @requests_support_request }
    end
  end

  # GET /requests/request_support_requests/1/edit
  def edit
    @requests_support_request = RequestsAdministration::SupportRequest.find(params[:id])
    # Obtener el comentario de Ubicación Fisica
    lv_sql ="SELECT DISTINCT * FROM request_commentaries
              WHERE support_request_id = " + params[:id] +
            " AND comment_type_id IN
                (SELECT id FROM catalogs_comment_types
                 WHERE abbr IN ('UBICA'))"
    @requests_request_req_ubication = RequestsAdministration::Commentary.find_by_sql(lv_sql)
    if @requests_request_req_ubication.size > 0
       @requests_support_request.req_ubication = @requests_request_req_ubication[0].commentaries
    end

  end

  # GET /requests/request_support_requests/1/scale
  def scale
    @requests_support_request = RequestsAdministration::SupportRequest.find(params[:id])
  end


  # POST /requests/request_support_requests
  # POST /requests/request_support_requests.xml
  def create
    @requests_support_request = RequestsAdministration::SupportRequest.new(params[:requests_administration_support_request])

    respond_to do |format|
      if @requests_support_request.save
        format.html { redirect_to(@requests_support_request, :notice => 'Support request was successfully created.') }
        format.xml  { render :xml => @requests_support_request, :status => :created, :location => @requests_support_request }
        # Guardar la ubicación fisica
        @catalogs_comment_types = Catalogs::CommentType.find(:first, :conditions => "abbr = 'UBICA'")
        request_commentary = RequestsAdministration::Commentary.new
        request_commentary.support_request_id =  @requests_support_request.id
        request_commentary.user_id = 0
        request_commentary.commentaries = @requests_support_request.req_ubication
        request_commentary.comment_type_id = @catalogs_comment_types.id
        request_commentary.save

      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @requests_support_request.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /requests/request_support_requests/1
  # PUT /requests/request_support_requests/1.xml
  def update
   @requests_support_request = RequestsAdministration::SupportRequest.find(params[:id])

       respond_to do |format|
           if @requests_support_request.update_attributes(params[:requests_administration_support_request])
              format.html { redirect_to(@requests_support_request, :notice => 'La solicitud fue actualizada.') }
              format.xml  { head :ok }

              #   Ubicar el comentario (Ubicación fisica)
              @comment =Catalogs::CommentType.find(:first, :conditions => "abbr = 'UBICA'")
              if @comment != nil
                 @requests_support_req_ubication =  RequestsAdministration::Commentary.find(:first,
                        :conditions => "support_request_id = " + params[:id] + "  AND comment_type_id = " + @comment.id.to_s)
                 if @requests_support_req_ubication != nil
                     if ( @requests_support_request.req_ubication != nil) &
                        (@requests_support_req_ubication.commentaries != @requests_support_request.req_ubication)
                            @requests_support_req_ubication.commentaries = @requests_support_request.req_ubication
                           @requests_support_req_ubication.save
                     end
                 end
               end
               #  Fin  Ubicar el comentario (Ubicación fisica)

           else
              format.html { render :action => "edit" }
              format.xml  { render :xml => @requests_support_request.errors, :status => :unprocessable_entity }
           end
        end  #respond do

#   usuario (autentificado)
    user_id = Administration::UserSession.find.record.attributes['id']

       #   Agregar comentario durante resolución
       if params.keys[0] == 'comment'
           if @requests_support_request.commentaries_to_add.length <= 0
              @requests_support_request.errors.add(:commentaries_to_add, '-Es necesario anotar un comentario.')
              return
           end

           @catalogs_comment_types = Catalogs::CommentType.find(:first, :conditions => "abbr = 'RESOL'")
           request_commentary = RequestsAdministration::Commentary.new
           request_commentary.support_request_id =  @requests_support_request.id
           request_commentary.user_id = user_id
           request_commentary.commentaries = @requests_support_request.commentaries_to_add
           request_commentary.comment_type_id = @catalogs_comment_types.id
           request_commentary.save

       end

#      Guardar movimientos de escalado de solicitud
       if params.keys[0] == 'commit'
          if @requests_support_request.helper_id != nil
             requests_req_delegation = Requests::ReqDelegation.new
             requests_req_delegation.support_request_id = @requests_support_request.id
             requests_req_delegation.user_id = user_id
             requests_req_delegation.helper_id = @requests_support_request.helper_id
             requests_req_delegation.notify = @requests_support_request.notify
             requests_req_delegation.save
             # Actualizar el estatus (Atendido)
             @requests_support_request.request_status_id = get_status_id('ST02')
             @requests_support_request.save
          end
       end

 end

  # DELETE /requests/request_support_requests/1
  # DELETE /requests/request_support_requests/1.xml
  def destroy
    @requests_support_request = Requests::SupportRequest.find(params[:id])
    @requests_support_request.destroy

    respond_to do |format|
      format.html { redirect_to(requests_administration_support_requests_url) }
      format.xml  { head :ok }
    end
  end

  # Dialogo de Cancelación de Solicitud
  def dialog_cancel
   @requests_support_request = Requests::SupportRequest.find(params[:id])
   lv_support_request_id = params[:id]


   user_id = Administration::UserSession.find.record.attributes['id']  #Usuario Actual
   ubicat_id = 0

   @user_act = user_info(user_id)
   @user_act.each do |user|
     ubicat_id = user.attributes['ubication_id']
   end



   # Obtener COMENTARIOS
   lv_sql ="SELECT * FROM request_commentaries
             WHERE support_request_id = " + lv_support_request_id.to_s() +
           "   AND comment_type_id IN
                (SELECT id FROM catalogs_comment_types
                 WHERE abbr = 'CANC')
              ORDER BY created_at DESC"


  #@requests_request_commentaries = Requests::RequestCommentary.find( :all, :conditions params[:id]=> ['"support_request_id" = ?', params[:id]] )
  @requests_request_commentaries = RequestsAdministration::Commentary.find_by_sql(lv_sql).paginate :page =>params[:page],:per_page=>5, :order => 'created_at ASC'

  end

  #Proceso de Cancelación de Solicitud
  def cancel
     # Guardar comentario sobre la cancelación
     if params[:commentaries_to_add].lstrip.rstrip.length > 0
         user_id = Administration::UserSession.find.record.attributes['id']
         @catalogs_comment_types = Catalogs::CommentType.find(:first, :conditions => "abbr = 'CANC'")
         request_commentary = RequestsAdministration::Commentary.new
         request_commentary.support_request_id =  params[:id]
         request_commentary.budget_id =  0
         request_commentary.user_id = user_id
         request_commentary.commentaries = params[:commentaries_to_add]
         request_commentary.comment_type_id = @catalogs_comment_types.id
         request_commentary.save
     end
     requests_support_request = Requests::SupportRequest.find(params[:id])
     requests_support_request.update_attribute :request_status_id, get_status_id("ST03") #Cancelado
     requests_support_request.save

     # Cambiar el status de todos los presupuestos
     Budgets::Budget.update_all("status_id =" + get_status_id("ST03").to_s,"support_request_id = "+ params[:id].to_s)

     redirect_to :action => "index"   
  end

end


