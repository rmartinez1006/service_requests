class Budgets::BudgetsController < ApplicationController

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
    @budgets_budget = Budgets::Budget.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @budgets_budget }
    end
  end

  # GET /budgets/budgets/new
  # GET /budgets/budgets/new.xml
  def new
    
    @budgets_budget = Budgets::Budget.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @budgets_budget }
    end
  end

  # GET /budgets/budgets/1/edit
  def edit
    @budgets_budget = Budgets::Budget.find(params[:id])
  end

  # POST /budgets/budgets
  # POST /budgets/budgets.xml
  def create    
    @budgets_budget = Budgets::Budget.new(params[:budgets_budget])
    respond_to do |format|
         if @budgets_budget.save
            #lv_buget_id = @budgets_budget.id
         else
            format.html { render :action => "budget_fm2" }
            format.xml  { render :xml => @budgets_budget.errors, :status => :unprocessable_entity }
         end       
    
         # Agregar material
         if params.keys[6] == "material"
            @budgets_budget_supply = Budgets::BudgetSupply.create(params[:budgets_budget_supply])
            Budgets::BudgetSupply.new(params[:budgets_budget_supply])
            @budgets_budget_supply.budget_id = @budgets_budget.id
            @budgets_budget_supply.save
#           Buscar los materiales que corresponden al presupuesto
            @budgets_budget_supplies = Budgets::BudgetSupply.find(:all,:conditions => "budget_id =" + @budgets_budget.id.to_s )
            render(:controller=>'/budgets/budgets', :action => "budget_fm1",  :id => 3 ) and return
         end

#   Guardar el presupuesto y salir
         @budgets_budgets = Budgets::Budget.all
         flash[:notice] = 'El presupuesto fue creado correctamente.'
         format.html { render :action => "index" }
         format.xml  { render :xml => @budgets_budgets }
    end
    
  end

  # PUT /budgets/budgets/1
  # PUT /budgets/budgets/1.xml
  def update

    @budgets_budget = Budgets::Budget.find(params[:id])

#   Validar el botón de "Agregar material"
    if params.keys[8] == "material"
          @budgets_budget_supply = Budgets::BudgetSupply.create!(params[:budgets_budget_supply])
          Budgets::BudgetSupply.new(params[:budgets_budget_supply])
          @budgets_budget_supply.budget_id = @budgets_budget.id
          @budgets_budget_supply.save

#         Buscar los materiales que corresponden al presupuesto
          @budgets_budget_supplies = Budgets::BudgetSupply.find(:all,:conditions => "budget_id =" + @budgets_budget.id.to_s )
          #render(:partial => 'supplies', :locals => { :list => true }) and return
          render(:controller=>'/budgets/budgets', :action => "budget_fm1",  :id => 3 ) and return
    end

#   Actualizar Presupuesto    
    respond_to do |format|
      if @budgets_budget.update_attributes(params[:budgets_budget])
        if params.keys[0]== 'commit'
           format.html { redirect_to(@budgets_budget, :notice => 'Budget was successfully updated.') }
           format.xml  { head :ok }
        end
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @budgets_budget.errors, :status => :unprocessable_entity }
      end
    end

  end

  # DELETE /budgets/budgets/1
  # DELETE /budgets/budgets/1.xml
  def destroy
    @budgets_budget = Budgets::Budget.find(params[:id])
    @budgets_budget.destroy

    respond_to do |format|
      format.html { redirect_to(budgets_budgets_url) }
      format.xml  { head :ok }
    end
  end

    # GET /budgets/budgets/1/budget_fm1
  def budget_fm1
    @requests_support_request = Requests::SupportRequest.find(params[:id])

#   Buscar si existe el presupeusto
    @budgets_budget = Budgets::Budget.find(:first, :conditions => "request_id ="+ params[:id] )
    if @budgets_budget == nil
#     NO existe Presupeusto: CREAR EL PRESUPUESTO
      @budgets_budget = Budgets::Budget.new
      @budgets_budget.request_id = params[:id]
#     Auxiliar
      @budgets_budget_supplies = Budgets::BudgetSupply.find(:all,:conditions => "budget_id =-1")
    else
#     Existe Presupuesto:
#     Buscar los materiales que corresponden al presupuesto
      @budgets_budget_supplies = Budgets::BudgetSupply.find(:all,:conditions => "budget_id =" + @budgets_budget.id.to_s )
    end
#    @budgets_budget_supplies = Budgets::BudgetSupply.all
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @budgets_budget }
      #format.xml  { render :xml => @requests_support_request }
    end
  end

 # GET /budgets/budgets/1/budget_fm1_edit
  def budget_fm1_edit
    @requests_support_request = Requests::SupportRequest.find(params[:id])
    @budgets_budget = Budgets::Budget.new
    @budgets_budget.request_id = params[:id]

#   Buscar los materiales que corresponden al presupuesto
    @budgets_budget_supplies = Budgets::BudgetSupply.all
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @budgets_budget }
      #format.xml  { render :xml => @requests_support_request }
    end
  end



    # GET /budgets/budgets/1/budget_fm1
  def budget_fm2
    @requests_support_request = Requests::SupportRequest.find(params[:id])

    #Nuevo Presupuesto
    @budgets_budget = Budgets::Budget.new
    @budgets_budget.request_id = params[:id]
    @budgets_budget.tech_description = @requests_support_request.tech_description
    @budgets_budget.support_type_id = @requests_support_request.support_type_id

    respond_to do |format|      
      format.html # new.html.erb      
      format.xml  { render :xml => @budgets_budget}
      format.xml  { render :xml => @requests_support_request }      
    end
  end


def add_supply
   @supply = Supply.create!(params[:supply])
   flash[:notice] = "Thanks for commenting!"
   respond_to do |format|
      format.html { redirect_to budgets_budget_supply_path }
      format.js
   end
end

end
