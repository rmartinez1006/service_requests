class Budgets::BudgetSupply < ActiveRecord::Base

 belongs_to :budget, :class_name => "Budgets::Budgets", :foreign_key => "budget_id"
  
 attr_accessor :other_material
 
 def importe(a, b)
  if a == nil || b== nil
    r = 0
  else
    r = a * b
  end
  r
 end

   #-- Valida si en el materia/mano de obra puede borrar
   def fn_borrar()
     role = Administration::UserSession.find.record.attributes['role']
     r= false
     case role
     when 'ADMIN','APRE','COORD'
       r = true
     end
     r
   end


end
