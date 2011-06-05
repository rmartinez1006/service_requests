#require 'fastercsv'

class Budgets::BudgetsController < ApplicationController
  include Common
  before_filter :authorize
  layout "budgets", :except => [:order]
  #layout 'login', :only => 'login'
  

  # GET /budgets/budgets
  # GET /budgets/budgets.xml
  def index

    lv_request_id = params[:request_id] # Si el parametro es mayor a cero entonces solo obtiene los presupuestos
                                # para la solicitud
    @budgets_budgets = get_list_budget(lv_request_id)
  
    
    #@budgets_budgets = Budgets::Budget.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @budgets_budgets }
    end


#    csv_string = FasterCSV.generate do |csv|
#      csv << ["budget_date", "total_cost" ]

#      @presup =  Budgets::Budget.find(:all);
   
#      csv << [@presup[0].budget_date,  @presup[0].total_cost]
#    end
   
#  FasterCSV.open("C:/file.csv", "w") do |csv|
#    csv << ["row", "of"]
#    csv << ["another", "row"]
#  end


 #   filename = "/home/martinezo/rmo.csv"
 #   send_data(csv_string,
 #     :type => 'text/csv; charset=utf-8; header=present',
 #     :filename => filename)

    
  end

  # GET /budgets/budgets/1
  # GET /budgets/budgets/1.xml
  def show
    $budget_type =1 # Presupuesto Interno
    $budget_id = 0
    $display_supplies = 1  #Mostrar area de captura de materiales   
    lv_budget_id = params[:id]
#   Buscar el presupuesto
    @budgets_budget = Budgets::Budget.find(lv_budget_id)
    if @budgets_budget == nil
    else
#     Solicitud
     @requests_support_request = RequestsAdministration::SupportRequest.find(:first, :conditions => "id ="+ @budgets_budget.support_request_id.to_s)
#     Buscar los materiales que corresponden al presupuesto
      @budgets_budget_supplies = Budgets::BudgetSupply.find(:all,:conditions => {:budget_id => @budgets_budget.id, :type_supply=>1} )
#     Buscar mano de obra que corresponden al presupuesto
      @budgets_budget_supplies2 = Budgets::BudgetSupply.find(:all,:conditions => {:budget_id => @budgets_budget.id, :type_supply=>2} )

      $budget_id = @budgets_budget.id
    end

    $permiso =get_num_aut_req(@budgets_budget.id,"V") #get_num_aut($budget_id)
    $autorizacion =get_num_aut(@budgets_budget.id)
    $display_supplies =@budgets_budget.budget_type

  end

  # GET /budgets/budgets/new
  # GET /budgets/budgets/new.xml
  def new

  end

  # GET /budgets/budgets/1/edit
  def edit
    @budgets_budget = Budgets::Budget.find(params[:id])
     if @budgets_budget.budget_type == 1
        $display_supplies = 1  #Mostrar area de captura de materiales
     else
         $display_supplies = 0  #NO Mostrar area de captura de materiales
     end
  end

  # POST /budgets/budgets
  # POST /budgets/budgets.xml
  def create
      if $budget_id == 0
#       Solo la primer vez crea el presupuesto
        @budgets_budget = Budgets::Budget.new(params[:budgets_budget])
        @budgets_budget.status_id = get_status_id('ST07')
        if @budgets_budget.save
           $budget_id = @budgets_budget.id
        else
           #@budgets_budget.errors.add(:total_cost, 'El costo total debe ser numerico mayor de cero.' )
           #render "shared/error_messages", :target => @budgets_budget
           return;
        end
      else
        @budgets_budget = Budgets::Budget.find($budget_id )
        @budgets_budget.attributes =  params[:budgets_budget] #
      end
      $autorizacion =get_num_aut($budget_id)

      # Agregar material
      if (@budgets_budget.mat_quantity.to_i > 0 ) && (@budgets_budget.mat_quantity.to_i!=-999.00)
          lv_description= @budgets_budget.mat_description
          lv_description= @budgets_budget.mat_other if @budgets_budget.mat_other!= ""
          @budgets_budget_supply =   Budgets::BudgetSupply.new :type_supply=> @budgets_budget.mat_type,
                                                               :budget_id=> $budget_id,
                                                               :description=> lv_description,
                                                               :unit_cost=> @budgets_budget.mat_import,
                                                               :quantity=> @budgets_budget.mat_quantity,
                                                               :unit_measure=> @budgets_budget.mat_unit
          @budgets_budget_supply.save
#         Buscar los materiales que corresponden al presupuesto
          @budgets_budget_supplies = Budgets::BudgetSupply.find(:all,:conditions => {:budget_id => @budgets_budget.id, :type_supply=>1} )
          return
      end
    
      # Agregar mano de obra
      if (@budgets_budget.work_quantity.to_i > 0 ) && (@budgets_budget.work_quantity.to_i!=-999.00)
          lv_description= @budgets_budget.work_description
          lv_description= @budgets_budget.work_other if @budgets_budget.work_other!= ""
          @budgets_budget_supply =   Budgets::BudgetSupply.new :type_supply=> @budgets_budget.work_type,
                                                               :budget_id=> $budget_id,
                                                               :description=> lv_description,
                                                               :unit_cost=> @budgets_budget.work_import,
                                                               :quantity=> @budgets_budget.work_quantity,
                                                               :unit_measure=> @budgets_budget.work_unit
          @budgets_budget_supply.save
#         Buscar los materiales que corresponden al presupuesto
          @budgets_budget_supplies2 = Budgets::BudgetSupply.find(:all,:conditions => {:budget_id => @budgets_budget.id, :type_supply=>2} )
          return
      end


#     Guardar el presupuesto y salir

      @budgets_budget.budget_type= $budget_type
      if $budget_type ==1     #Presupuesto Interno (Tiene Materiales y mano de obra)
         @budgets_budget_supplies = Budgets::BudgetSupply.find(:all,:conditions => "budget_id =" + @budgets_budget.id.to_s )
#        Obtener el Importe Total (Gran Total)
#        primero, buscar los materiales que corresponden al presupuesto
         sum = 0
         sum = @budgets_budget.suma_total(@budgets_budget_supplies)
         @budgets_budget.total_cost = sum
      else
         @budgets_budget.total_cost = @budgets_budget.unit_cost  * @budgets_budget.quantity
      end
      if @budgets_budget.save
#        Guardar el Tipo de Soporte en la Solicitud
         @requests_support_request = RequestsAdministration::SupportRequest.find(@budgets_budget.support_request_id)
         @budgets_budget.tech_description = @budgets_budget.tech_description
         @requests_support_request.support_type_id = @budgets_budget.support_type_id
          # Actualizar el estatus (Atendido)
         @requests_support_request.request_status_id = get_status_id('ST07')
         @requests_support_request.save
      end
      
#     Guardar autorización (commentary)
      lv_guardar = 0
      if ($autorizacion == 1) & (params[:chk_analista]=='1')
        lv_autorizacion ='AUT-P01'
        lv_comentario = @budgets_budget.add_aut_analista
        lv_guardar = 1
        lv_status = 'ST08'
      end

      if ($autorizacion == 2) & (params[:chk_aut_02]=='1')
         lv_autorizacion ='AUT-P02'
         lv_comentario = @budgets_budget.add_aut_02
         lv_guardar = 1
         lv_status = 'ST09'
      end
      if ($autorizacion == 3) & (params[:chk_aut_03]=='1')
         lv_autorizacion ='AUT-P03'
         lv_comentario = @budgets_budget.add_aut_03
         lv_guardar = 1
         lv_status = 'ST10'
      end

      if ($autorizacion == 4) & (params[:chk_aut_04]=='1')
         lv_autorizacion ='AUT-P04'
         lv_comentario = @budgets_budget.add_aut_04
         lv_guardar = 1
         lv_status = 'ST11'
      end

      if ($autorizacion == 5) & (params[:chk_aut_05]=='1')
         lv_autorizacion ='AUT-P05'
         lv_comentario = @budgets_budget.add_aut_05
         lv_guardar = 1
         lv_status = 'ST12'
         # Validar que exista fecha de Termino
         if @budgets_budget.ending_date == nil or @budgets_budget.ending_date == ''
            @budgets_budget.errors.add(:ending_date, '-Es un dato requerido.')
            return
         end
         # Validar que exista el número de Orden
         if $budget_type == 2
            if @budgets_budget.order_num == nil or @budgets_budget.order_num.empty?
               @budgets_budget.errors.add(:order_num, '-Es un dato requerido.')
               return
            end
         end

      end
    
      if (lv_guardar == 1)
         unless lv_autorizacion == nil
             if (lv_comentario == nil) | (lv_comentario=="" )
                 lv_comentario = "Sin comentario."
             end
          end

         @catalogs_comment_types = Catalogs::CommentType.find(:first, :conditions => "abbr = '"+ lv_autorizacion +"'")
         request_commentary = Requests::RequestCommentary.new
         request_commentary.budget_id =  $budget_id
         request_commentary.user_id = Administration::UserSession.find.record.attributes['id']
         request_commentary.commentaries = lv_comentario
         request_commentary.comment_type_id = @catalogs_comment_types.id
         request_commentary.support_request_id = @budgets_budget.support_request_id
         request_commentary.save
         # Actualizar Status de solicitud
         @budgets_budget.set_status_id_req(@requests_support_request.id, lv_status)
         @budgets_budget.status_id = get_status_id(lv_status)
         @budgets_budget.save
      end
      # Instrucciones (Comentario)
      if (params[:chk_instruc] == '1')
         comment_save("INSTR", $budget_id, @budgets_budget.support_request_id,@requests_support_request,@budgets_budget)
      end
    

      @budgets_budgets = Budgets::Budget.all
      render :update do |page|
            page.redirect_to(:action=>"index")
      end
      
  end

  # PUT /budgets/budgets/1
  # PUT /budgets/budgets/1.xml
  def update
      @budgets_budget = Budgets::Budget.find(params[:id])
      if @budgets_budget!= nil
        lv_req_id = @budgets_budget.support_request_id
        @budgets_budget.attributes =  params[:budgets_budget]
         $autorizacion =get_num_aut(@budgets_budget.id)
      end

      if $autorizacion != 4
#         @budgets_budget.attributes =  params[:budgets_budget]
#         Validar el botón de "Agregar material"
#         Agregar material
          if (@budgets_budget.mat_quantity.to_i > 0 ) && (@budgets_budget.mat_quantity.to_i!=-999.00)
              lv_description= @budgets_budget.mat_description
              lv_description= @budgets_budget.mat_other if @budgets_budget.mat_other!= ""
              @budgets_budget_supply =   Budgets::BudgetSupply.new :type_supply=> @budgets_budget.mat_type,
                                                                   :budget_id=> $budget_id,
                                                                   :description=> lv_description,
                                                                   :unit_cost=> @budgets_budget.mat_import,
                                                                   :quantity=> @budgets_budget.mat_quantity,
                                                                   :unit_measure=> @budgets_budget.mat_unit
              @budgets_budget_supply.save
#             Buscar los materiales que corresponden al presupuesto
              @budgets_budget_supplies = Budgets::BudgetSupply.find(:all,:conditions => {:budget_id => @budgets_budget.id, :type_supply=>1} )
              return
          end

#         Agregar mano de obra
          if (@budgets_budget.work_quantity.to_i > 0 ) && (@budgets_budget.work_quantity.to_i!=-999.00)
              lv_description= @budgets_budget.work_description
              lv_description= @budgets_budget.work_other if @budgets_budget.work_other!= ""
              @budgets_budget_supply =   Budgets::BudgetSupply.new :type_supply=> @budgets_budget.work_type,
                                                                   :budget_id=> $budget_id,
                                                                   :description=> lv_description,
                                                                   :unit_cost=> @budgets_budget.work_import,
                                                                   :quantity=> @budgets_budget.work_quantity,
                                                                   :unit_measure=> @budgets_budget.work_unit
              @budgets_budget_supply.save
#             Buscar los materiales que corresponden al presupuesto
              @budgets_budget_supplies2 = Budgets::BudgetSupply.find(:all,:conditions => {:budget_id => @budgets_budget.id, :type_supply=>2} )
              return
          end

#         Actualizar Presupuesto
          @budgets_budget.budget_type= $budget_type
          @budgets_budget.attributes =  params[:budgets_budget]
          @budgets_budget.status_id = get_status_id('ST07')
          lv_ending_date = params[:budgets_budget][:ending_date]
          #lv_ending_date = lv_ending_date.gsub("-","/") Date.strptime(params[:budgets_budget][:ending_date], "%d/%m/%Y")
          if lv_ending_date != nil and lv_ending_date!=''
             @budgets_budget.ending_date = Date.strptime(lv_ending_date, "%d/%m/%Y")
          end
          if $budget_type ==1     #Presupuesto Interno (Tiene Materiales y mano de obra)
             @budgets_budget_supplies = Budgets::BudgetSupply.find(:all,:conditions => {:budget_id => @budgets_budget.id} )
#            Obtener el Importe Total (Gran Total)
#            primero, buscar los materiales que corresponden al presupuesto
             sum = 0
             sum = @budgets_budget.suma_total(@budgets_budget_supplies)
             @budgets_budget.total_cost = sum
          else
            @budgets_budget.total_cost = @budgets_budget.unit_cost  * @budgets_budget.quantity
          end

#         Validar que el importe sea mayor a cero
          if @budgets_budget.total_cost <= 0
            @budgets_budget.errors.add(:total_cost, '-debe ser numerico mayor de cero.')
            return
          end


          if @budgets_budget.save
#            Guardar el Tipo de Soporte en la Solicitud
#            Ubicar la solicitud
             @requests_support_request = RequestsAdministration::SupportRequest.find(@budgets_budget.support_request_id)
             @budgets_budget.tech_description = @budgets_budget.tech_description
             @requests_support_request.support_type_id = @budgets_budget.support_type_id
#            Actualizar el estatus (Atendido)
             @requests_support_request.request_status_id = get_status_id('ST07')
             @requests_support_request.save
          else #cuando error
            return;

          end

#     Guardar autorización (commentary)
      end # Si es $Autorizacion = 4 (Autorizacion del Secretario Tecnico)
      lv_guardar = 0
      if ($autorizacion == 1) & (params[:chk_analista]=='1')
        lv_autorizacion ='AUT-P01'
        lv_comentario = @budgets_budget.add_aut_analista
        lv_guardar = 1
        lv_status = 'ST08'
      end

      if ($autorizacion == 2) & (params[:chk_aut_02]=='1')
         lv_autorizacion ='AUT-P02'
         lv_comentario = @budgets_budget.add_aut_02
         lv_guardar = 1
         lv_status = 'ST09'
      end

      if ($autorizacion == 3) & (params[:chk_aut_03]=='1')
         lv_autorizacion ='AUT-P03'
         lv_comentario = @budgets_budget.add_aut_03
         lv_guardar = 1
         lv_status='ST10'
      end

      if ($autorizacion == 4) & (params[:chk_aut_04]=='1')
         lv_autorizacion ='AUT-P04'
         lv_comentario = @budgets_budget.add_aut_04
         lv_guardar = 1
         lv_status = 'ST11'
      end

      if ($autorizacion == 5) & (params[:chk_aut_05]=='1')
         lv_autorizacion ='AUT-P05'
         lv_comentario = @budgets_budget.add_aut_05
         lv_guardar = 1
         lv_status = 'ST12'
         # Validar que exista fecha de Termino
         if @budgets_budget.ending_date == nil or @budgets_budget.ending_date == ''
            @budgets_budget.errors.add(:ending_date, '-Es un dato requerido.')
            return
         end
         # Validar que exista el número de Orden
         if $budget_type == 2
            if @budgets_budget.order_num == nil or @budgets_budget.order_num.empty?
               @budgets_budget.errors.add(:order_num, '-Es un dato requerido.')
               return
            end
         end   
      end


      if (lv_guardar == 1)
         unless lv_autorizacion == nil
             if (lv_comentario == nil) | (lv_comentario=="" )
                 lv_comentario = "Sin comentario."
             end
          end

         @catalogs_comment_types = Catalogs::CommentType.find(:first, :conditions => "abbr = '"+ lv_autorizacion +"'")
         request_commentary = Requests::RequestCommentary.new
         request_commentary.budget_id =  $budget_id
         request_commentary.user_id = Administration::UserSession.find.record.attributes['id']
         request_commentary.commentaries = lv_comentario
         request_commentary.comment_type_id = @catalogs_comment_types.id
         request_commentary.support_request_id = @budgets_budget.support_request_id
         request_commentary.save
         # Actualizar Status de solicitud
         @budgets_budget.set_status_id_req(@budgets_budget.support_request_id, lv_status)
         @budgets_budget.status_id = get_status_id(lv_status)
         @budgets_budget.save
      end

      # Instrucciones (Comentario)
      if (params[:chk_instruc] == '1')
         comment_save("INSTR", $budget_id, @budgets_budget.support_request_id,@requests_support_request,@budgets_budget)
      end

      
      #@budgets_budgets = Budgets::Budget.all
      render :update do |page|
            page.redirect_to(:action=>"index")
      end
  end

  # DELETE /budgets/budgets/1
  # DELETE /budgets/budgets/1.xml
  def destroy    
    @budgets_budget = Budgets::Budget.find(params[:id])
    lv_request = @budgets_budget.support_request_id
    @budgets_budget.destroy
    # Actualizar el estatus de la solicitud => (Atendido)
    @requests_support_request = Requests::SupportRequest.find(lv_request)
    @requests_support_request.request_status_id = get_status_id('ST02')
    @requests_support_request.save
    render :update do |page|
          page.redirect_to(:action=>"index")
    end

  end



  def delete_supply #Borra Material
    @budgets_budget_supply = Budgets::BudgetSupply.find(params[:id])
    @budgets_budget_supply.destroy    
    @budgets_budget_supplies = Budgets::BudgetSupply.find(:all,:conditions => {:budget_id => $budget_id, :type_supply=>1} )#+   
  end

  def delete_supply2 #Borrar Mano de Obra
    @budgets_budget_supply = Budgets::BudgetSupply.find(params[:id])
    @budgets_budget_supply.destroy
    @budgets_budget_supplies2 = Budgets::BudgetSupply.find(:all,:conditions => {:budget_id => $budget_id, :type_supply=>2} )#
  end


# GET /budgets/budgets/1/budget_fm1
  def budget_fm1
    $budget_type =1 # Presupuesto Interno
    $budget_id = 0
    $display_supplies = 1  #Mostrar area de captura de materiales
    lv_new = params[:new]   #1 = Es nuevo presupuesto
#    @requests_support_request = RequestsAdministration::SupportRequest.find(params[:id])
#    @combo = Catalogs::Supply.find(:all,  :conditions => "type_supply = 1").collect{|p| [p.description, p.unit_cost.to_s, p.description]}

#   ACTUALIZACION (Se pasa el ID del PRESUPUESTO como parametro)
    if lv_new != '1'
       @budgets_budget = Budgets::Budget.find(:first, :conditions => "id ="+ params[:id])
       @requests_support_request = RequestsAdministration::SupportRequest.find(@budgets_budget.support_request_id)
       if @budgets_budget == nil
          lv_new = 1
       end
      @budgets_budget_supplies = Budgets::BudgetSupply.find(:all,:conditions => {:budget_id => @budgets_budget.id, :type_supply=>1} )
#     Buscar mano de obra que corresponden al presupuesto
      @budgets_budget_supplies2 = Budgets::BudgetSupply.find(:all,:conditions => {:budget_id => @budgets_budget.id, :type_supply=>2} )
      $budget_id = @budgets_budget.id
    end

#   NUEVO PRESUPUESTO (se pasa el ID de las SOLICITUD como parametro)
    if lv_new == '1'
      @budgets_budget = Budgets::Budget.new
      @budgets_budget.support_request_id = params[:id]
#     Auxiliar
      @budgets_budget_supplies = Budgets::BudgetSupply.find(:all,:conditions => "budget_id =-1")
      @budgets_budget_supplies2 = Budgets::BudgetSupply.find(:all,:conditions => "budget_id =-1")
      @requests_support_request = RequestsAdministration::SupportRequest.find(params[:id])
    end
    #Tomar los datos de la Solicitud y mostrarlos
    @budgets_budget.tech_description = @requests_support_request.tech_description
    @budgets_budget.support_type_id = @requests_support_request.support_type_id
    $autorizacion =get_num_aut($budget_id)
  end


  # PRESUPUESTO EXTERNO
  # GET /budgets/budgets/1/budget_fm1
  def budget_fm2
    $budget_type =2 # Presupuesto Externo
    $budget_id = 0
    $display_supplies = 0
    lv_new = params[:new]   #1 = Es nuevo presupuesto


#   ACTUALIZACION (Se pasa el ID del PRESUPUESTO como parametro)
    if lv_new != '1'
       @budgets_budget = Budgets::Budget.find(:first, :conditions => "id ="+ params[:id])
       @requests_support_request = RequestsAdministration::SupportRequest.find(@budgets_budget.support_request_id)
       if @budgets_budget == nil
          lv_new = 1
       end
      @budgets_budget.ending_date = @budgets_budget.ending_date.strftime("%d/%m/%Y") if @budgets_budget.ending_date != nil
      $budget_id = @budgets_budget.id
    end


#   NUEVO PRESUPUESTO (Se pasa como parametro el ID de SOLICITUD)
    if lv_new == '1'
      @budgets_budget = Budgets::Budget.new
      @budgets_budget.support_request_id = params[:id]
      @requests_support_request = RequestsAdministration::SupportRequest.find(params[:id])
    end

    #Tomar los datos de la Solicitud y mostrarlos
    @budgets_budget.tech_description = @requests_support_request.tech_description
    @budgets_budget.support_type_id = @requests_support_request.support_type_id
    $autorizacion =get_num_aut($budget_id)
  end


  def order
    $budget_type =1 # Presupuesto Interno
    $budget_id = 0
    $display_supplies = 1  #Mostrar area de captura de materiales
    @requests_support_request = RequestsAdministration::SupportRequest.find(params[:id])
#    @combo = Catalogs::Supply.find(:all,  :conditions => "type_supply = 1").collect{|p| [p.description, p.unit_cost.to_s, p.description]}

#   Buscar si existe el presupeusto
    @budgets_budget = Budgets::Budget.find(:first, :conditions => "support_request_id ="+ params[:id] )
    if @budgets_budget == nil
    else
#     Buscar los materiales que corresponden al presupuesto
      @budgets_budget_supplies = Budgets::BudgetSupply.find(:all,:conditions => {:budget_id => @budgets_budget.id, :type_supply=>1} )
#     Buscar mano de obra que corresponden al presupuesto
      @budgets_budget_supplies2 = Budgets::BudgetSupply.find(:all,:conditions => {:budget_id => @budgets_budget.id, :type_supply=>2} )

      $budget_id = @budgets_budget.id
    end

    $permiso =get_num_aut_req(@budgets_budget.support_request_id,"V") #get_num_aut($budget_id)
    $autorizacion =get_num_aut(@budgets_budget.id)
    $display_supplies =@budgets_budget.budget_type
    render :layout => "budget_order"
  end

# Comentarios e instrucciones
  def info
   @requests_support_request = Requests::SupportRequest.find(params[:id])
   @budgets_budget = Budgets::Budget.find(params[:budget_id])
   lv_support_request_id = params[:id]
   $budget_id = @budgets_budget.id

   user_id = Administration::UserSession.find.record.attributes['id']  #Usuario Actual
   ubicat_id = 0

   @user_act = user_info(user_id)
   @user_act.each do |user|
     ubicat_id = user.attributes['ubication_id']
   end

   lv_budget_id = params[:budget_id]

   # Obtener COMENTARIOS
   lv_sql ="SELECT * FROM request_commentaries
             WHERE (budget_id = " + lv_budget_id.to_s() + " OR support_request_id = " + lv_support_request_id +")"+
           "   AND comment_type_id IN
                (SELECT id FROM catalogs_comment_types
                 WHERE abbr IN ('RESOL','AUT-P02','AUT-P03','AUT-P04','AUT-P05'))"

   lv_sql =lv_sql + " UNION SELECT * FROM request_commentaries
              WHERE budget_id = " + lv_budget_id.to_s() +
            " AND comment_type_id IN
                (SELECT id FROM catalogs_comment_types
                 WHERE abbr IN ('INSTR'))
              AND user_id IN (SELECT id FROM administration_users WHERE ubication_id = "+ ubicat_id.to_s() +")
              ORDER BY created_at DESC"


  #@requests_request_commentaries = Requests::RequestCommentary.find( :all, :conditions params[:id]=> ['"support_request_id" = ?', params[:id]] )
  @requests_request_commentaries = RequestsAdministration::Commentary.find_by_sql(lv_sql).paginate :page =>params[:page],:per_page=>5, :order => 'created_at ASC'

    
  end

  
  def comment
     #@budgets_budget = Budgets::Budget.find(params[:id])

     if params[:add_comment].length <= 0
              @budgets_budget.errors.add(:add_comment, '-Es necesario anotar un comentario.')
              return
      end

      user_id = Administration::UserSession.find.record.attributes['id']
      @catalogs_comment_types = Catalogs::CommentType.find(:first, :conditions => "abbr = 'RESOL'")
      request_commentary = RequestsAdministration::Commentary.new
      request_commentary.support_request_id =  params[:id]
      request_commentary.budget_id =  $budget_id
      request_commentary.user_id = user_id
      request_commentary.commentaries = params[:add_comment]
      request_commentary.comment_type_id = @catalogs_comment_types.id
      request_commentary.save

      redirect_to :action => "info",:budget_id=> $budget_id

  end
  
end