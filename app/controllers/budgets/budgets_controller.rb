class Budgets::BudgetsController < ApplicationController
  before_filter :authorize
  layout "budgets"

  
  # GET /budgets/budgets
  # GET /budgets/budgets.xml
  def index  
    @budgets_budgets = Budgets::Budget.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @budgets_budgets }
    end
  end

  # GET /budgets/budgets/1
  # GET /budgets/budgets/1.xml
  def show
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

      # Agregar material
      @budgets_budget_supply = Budgets::BudgetSupply.new(params[:budgets_budget_supply])
      if @budgets_budget_supply.quantity > 0
            if @budgets_budget_supply.quantity != -999.00
               @budgets_budget_supply = Budgets::BudgetSupply.new(params[:budgets_budget_supply])
               @budgets_budget_supply.budget_id = $budget_id   #@budgets_budget.id
               @budgets_budget_supply.save
#              Buscar los materiales que corresponden al presupuesto
               @budgets_budget_supplies = Budgets::BudgetSupply.find(:all,:conditions => "budget_id =" + @budgets_budget.id.to_s )
               return
           end
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
         @requests_support_request.save
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
#     Validar el botón de "Agregar material"
      # Agregar material
      @budgets_budget_supply = Budgets::BudgetSupply.new(params[:budgets_budget_supply])
      if @budgets_budget_supply.quantity > 0
        if @budgets_budget_supply.quantity != -999.00
            @budgets_budget_supply = Budgets::BudgetSupply.new(params[:budgets_budget_supply])
            @budgets_budget_supply.budget_id = @budgets_budget.id
            @budgets_budget_supply.save
#           Buscar los materiales que corresponden al presupuesto
            @budgets_budget_supplies = Budgets::BudgetSupply.find(:all,:conditions => "budget_id =" + @budgets_budget.id.to_s )
            return
        end
      end
#     Actualizar Presupuesto
      
      @budgets_budget.budget_type= $budget_type
      @budgets_budget.attributes =  params[:budgets_budget]
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
#        Ubicar la solicitud
         @requests_support_request = RequestsAdministration::SupportRequest.find(@budgets_budget.support_request_id)
         @budgets_budget.tech_description = @budgets_budget.tech_description
         @requests_support_request.support_type_id = @budgets_budget.support_type_id
         @requests_support_request.save
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
    @budgets_budget.destroy
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
    else
#     Existe Presupuesto:
#     Buscar los materiales que corresponden al presupuesto
      @budgets_budget_supplies = Budgets::BudgetSupply.find(:all,:conditions => "budget_id =" + @budgets_budget.id.to_s )
      $budget_id = @budgets_budget.id
    end
    #Tomar los datos de la Solicitud y mostrarlos
    @budgets_budget.tech_description = @requests_support_request.tech_description
    @budgets_budget.support_type_id = @requests_support_request.support_type_id
    
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

  end



  def delete_supply
    @budgets_budget_supply = Budgets::BudgetSupply.find(params[:id])
    @budgets_budget_supply.destroy
    @budgets_budget_supplies = Budgets::BudgetSupply.find(:all,:conditions => "budget_id =" + $budget_id.to_s )#+
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