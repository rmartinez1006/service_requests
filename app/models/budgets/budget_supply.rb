class Budgets::BudgetSupply < ActiveRecord::Base

  belongs_to :budget, :class_name => "Budgets::Budgets", :foreign_key => "budget_id"
  

 def importe(a, b)
  if a == nil || b== nil
    r = 0
  else
    r = a * b
  end
  r
 end



end
