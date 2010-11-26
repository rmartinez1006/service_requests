class Budgets::BudgetSupply < ActiveRecord::Base

 def importe(a, b)
  if a == nil || b== nil
    r = 0
  else
    r = a * b
  end
  r
 end



end
