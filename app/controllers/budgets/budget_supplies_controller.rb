class Budgets::BudgetSuppliesController < ApplicationController
  # GET /budgets/budget_supplies
  # GET /budgets/budget_supplies.xml
validates_numericality_of :unit_cost, :on => :create, :message => "Debe ser númerico."
validates_numericality_of :quantity, :on => :create, :message => "Debe ser númerico."


  def index
    
    @budgets_budget_supplies = Budgets::BudgetSupply.all
    respond_to do |format|
      format.html # index.html.erb
      format.rss
    end
        
  end

  # GET /budgets/budget_supplies/1
  # GET /budgets/budget_supplies/1.xml
  def show
    @budgets_budget_supply = Budgets::BudgetSupply.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @budgets_budget_supply }
    end
  end

  # GET /budgets/budget_supplies/new
  # GET /budgets/budget_supplies/new.xml
  def new
    @budgets_budget_supply = Budgets::BudgetSupply.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @budgets_budget_supply }
    end
  end

  # GET /budgets/budget_supplies/1/edit
  def edit
    @budgets_budget_supply = Budgets::BudgetSupply.find(params[:id])
  end

  # POST /budgets/budget_supplies
  # POST /budgets/budget_supplies.xml
  def create

    @budgets_budget_supply = Budgets::BudgetSupply.create!(params[:budgets_budget_supply])
#    @budgets_budget_supply = Budgets::BudgetSupply.new(params[:budgets_budget_supply])
    respond_to do |format|
      if @budgets_budget_supply.save
        format.html { redirect_to budgets_budget_supplies_path }
#        format.html { redirect_to(@budgets_budget_supply, :notice => 'Budget supply was successfully created.') }
#        format.xml  { render :xml => @budgets_budget_supply, :status => :created, :location => @budgets_budget_supply }
        format.js
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @budgets_budget_supply.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /budgets/budget_supplies/1
  # PUT /budgets/budget_supplies/1.xml
  def update
    @budgets_budget_supply = Budgets::BudgetSupply.find(params[:id])

    respond_to do |format|
      if @budgets_budget_supply.update_attributes(params[:budgets_budget_supply])
        format.html { redirect_to(@budgets_budget_supply, :notice => 'Budget supply was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @budgets_budget_supply.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /budgets/budget_supplies/1
  # DELETE /budgets/budget_supplies/1.xml
  def destroy
    @budgets_budget_supply = Budgets::BudgetSupply.find(params[:id])
    @budgets_budget_supply.destroy

    respond_to do |format|
      format.html { redirect_to(budgets_budget_supplies_url) }
      format.xml  { head :ok }
    end
  end



  

end