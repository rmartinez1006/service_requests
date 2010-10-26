class Budgets::BudgetsController < ApplicationController
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
        format.html { redirect_to(@budgets_budget, :notice => 'Budget was successfully created.') }
        format.xml  { render :xml => @budgets_budget, :status => :created, :location => @budgets_budget }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @budgets_budget.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /budgets/budgets/1
  # PUT /budgets/budgets/1.xml
  def update
    @budgets_budget = Budgets::Budget.find(params[:id])

    respond_to do |format|
      if @budgets_budget.update_attributes(params[:budgets_budget])
        format.html { redirect_to(@budgets_budget, :notice => 'Budget was successfully updated.') }
        format.xml  { head :ok }
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

    # GET /requests/support_requests/1/scale
  def new_budget
    @requests_support_request = Requests::SupportRequest.find(params[:id])

    @budgets_budget = Budgets::Budget.new

    @budgets_budget.request_id = params[:id]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @budgets_budget }
      format.xml  { render :xml => @requests_support_request }
    end

  end

end
