class Budgets::BudgetsController < ApplicationController
  include Common
  before_filter :authorize
  layout "budgets"

  
  # GET /budgets/budgets
  # GET /budgets/budgets.xml
  def index  
    @budgets_budgets = get_list_budget()
    #@budgets_budgets = Budgets::Budget.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @budgets_budgets }
    end
  end

  # GET /budgets/budgets/1
  # GET /budgets/budgets/1.xml
  def show
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

    $autorizacion =get_num_aut($budget_id)
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
        @budgets_budget.save
        $budget_id = @budgets_budget.id
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
      end

      if ($autorizacion == 2) & (params[:chk_aut_02]=='1')
         lv_autorizacion ='AUT-P02'
         lv_comentario = @budgets_budget.add_aut_02
         lv_guardar = 1
      end
      if ($autorizacion == 3) & (params[:chk_aut_03]=='1')
         lv_autorizacion ='AUT-P03'
         lv_comentario = @budgets_budget.add_aut_03
         lv_guardar = 1
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
         request_commentary.commentaries = @requests_support_request.req_ubication
         request_commentary.comment_type_id = @catalogs_comment_types.id
         request_commentary.save
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

      if $autorizacion != 3
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
          if $budget_type ==1     #Presupuesto Interno (Tiene Materiales y mano de obra)
             @budgets_budget_supplies = Budgets::BudgetSupply.find(:all,:conditions => {:budget_id => @budgets_budget.id} )
#            Obtener el Importe Total (Gran Total)
#            primero, buscar los materiales que corresponden al presupuesto
             sum = 0
             sum = @budgets_budget.suma_total(@budgets_budget_supplies)
             @budgets_budget.total_cost = sum
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
          end

#     Guardar autorización (commentary)
      end # Si es $Autorizacion = 3 (Autorizacion del Secretario Tecnico)
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
         request_commentary.save
         # Actualizar Status de solicitud
         @budgets_budget.set_status_id_req(support_request_id, status)

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

    # GET /budgets/budgets/1/budget_fm1
  def budget_fm1
    $budget_type =1 # Presupuesto Interno    
    $budget_id = 0
    $display_supplies = 1  #Mostrar area de captura de materiales
    @requests_support_request = RequestsAdministration::SupportRequest.find(params[:id])
#    @combo = Catalogs::Supply.find(:all,  :conditions => "type_supply = 1").collect{|p| [p.description, p.unit_cost.to_s, p.description]}

#   Buscar si existe el presupeusto
    @budgets_budget = Budgets::Budget.find(:first, :conditions => "support_request_id ="+ params[:id] )
    if @budgets_budget == nil
#     NO existe Presupeusto: CREAR EL PRESUPUESTO
      @budgets_budget = Budgets::Budget.new
      @budgets_budget.support_request_id = params[:id]      
#     Auxiliar
      @budgets_budget_supplies = Budgets::BudgetSupply.find(:all,:conditions => "budget_id =-1")
      @budgets_budget_supplies2 = Budgets::BudgetSupply.find(:all,:conditions => "budget_id =-1")
    else
#     Existe Presupuesto:
#     Buscar los materiales que corresponden al presupuesto
      @budgets_budget_supplies = Budgets::BudgetSupply.find(:all,:conditions => {:budget_id => @budgets_budget.id, :type_supply=>1} )
#     Buscar mano de obra que corresponden al presupuesto
      @budgets_budget_supplies2 = Budgets::BudgetSupply.find(:all,:conditions => {:budget_id => @budgets_budget.id, :type_supply=>2} )

      $budget_id = @budgets_budget.id
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
    @requests_support_request = RequestsAdministration::SupportRequest.find(params[:id])

#   Buscar si existe el presupeusto
    @budgets_budget = Budgets::Budget.find(:first, :conditions => "support_request_id ="+ params[:id] )
    if @budgets_budget == nil
#     NO existe Presupeusto: CREAR EL PRESUPUESTO
      @budgets_budget = Budgets::Budget.new
      @budgets_budget.support_request_id = params[:id]
#      @budgets_budget.flag_create = 'create' #Bandera Indica que se debe crear el presupuesto
    else
#     Existe Presupuesto:
      $budget_id = @budgets_budget.id
    end
    #Tomar los datos de la Solicitud y mostrarlos
    @budgets_budget.tech_description = @requests_support_request.tech_description
    @budgets_budget.support_type_id = @requests_support_request.support_type_id
    $autorizacion =get_num_aut($budget_id)
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



 # GET /budgets/budgets/1/budget_fm1_edit
  def budget_fm1_edit    
    redirect_to budgets_budget_fm1_path(params[:id])
    return
    @requests_support_request =  RequestsAdministration::SupportRequest.find(params[:id])
    @budgets_budget = Budgets::Budget.find(:first,:conditions => "support_request_id =" + @requests_support_request.id.to_s )
    @budgets_budget.tech_description = @requests_support_request.tech_description

#   Buscar los materiales que corresponden al presupuesto
    @budgets_budget_supplies = Budgets::BudgetSupply.find(:all,:conditions => "budget_id =" + @budgets_budget.id.to_s )
     redirect_to budgets_budget_fm1_path(@budgets_budget.support_request_id)
  end


end