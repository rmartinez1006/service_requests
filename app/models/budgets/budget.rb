class Budgets::Budget < ActiveRecord::Base
  belongs_to :request, :class_name => "RequestsAdministration::SupportRequest", :foreign_key => "support_request_id"
  belongs_to :supplier, :class_name => "Catalogs::Supplier", :foreign_key => "supplier_id"
  belongs_to :user, :class_name => "Administration::User", :foreign_key => "user_id"


  has_many :supply, :class_name => 'Budgets::BudgetSupply',:foreign_key => "budget_id"

  attr_accessor :support_type_id, :tech_description, :description_supply,
                :mat_unit, :mat_description, :mat_quantity, :mat_cost, :mat_import, :mat_type, :mat_other,
                :work_unit, :work_description, :work_quantity, :work_cost, :work_import, :work_type, :work_other,
                :add_aut_analista, :add_aut_02, :add_aut_03, :add_aut_04, :chk_analista, :chk_aut_02, :chk_aut_03, :chk_aut_04

include Common

#validates_format_of :total_cost, :with => /\d{0,10}\./
# validates_format_of :total_cost, :with => /\d{0,10}\.\d{2}/
validates_numericality_of :total_cost, :on => :create, :message => "Debe ser númerico."

  def before_save
    lv_user_id = Administration::UserSession.find.record.attributes['id']
    if  self.budget_date == nil
      self.budget_date = Time.now
      self.user_id = lv_user_id
    end
  end


  def after_save
    unless self.support_request_id == nil
#       Obtene clave de estatus "ST07"
        @status_req = Catalogs::RequestStatus.find(:first, :conditions => "abbr = 'ST07'")
        lv_status_id = @status_req.id
#       Actuself.support_request_idalizar la descripción Tecnica y Tipo de Soporte
        @requests_support_request = RequestsAdministration::SupportRequest.find(self.support_request_id)
        @requests_support_request.tech_description = self.tech_description
        @requests_support_request.support_type_id = self.support_type_id
        @requests_support_request.request_status_id = lv_status_id
        @requests_support_request.save
    end

  end


#Obtener el total de los materiales o mano de obra
 def suma_total(budgets_supplies)
   sum = 0
   for item in budgets_supplies
     sum = sum + item.unit_cost * item.quantity
   end
   sum
 end


   #-- devuelve true si existe la autorización
   def valida_budget_aut(budget_id)
     r = true #Tiene permiso para EDITAR

     # Si existe la autorizacion 1, el ANALISTA ya no puede editar
     lv_role = Administration::UserSession.find.record.attributes['role']
     if lv_role == 'APRE'
        lv_autorizacion ="='AUT-P01'"
     end


     # Si esta pendiente la autorizacion 3  no se puede Editar el presupuesto
     if (lv_role == 'COORD') |  (lv_role == 'ADMIN')
       lv_autorizacion = " ='AUT-P03'"
     end


     if lv_autorizacion == nil
       r = false
       return
     end

     lv_sql ="SELECT * FROM request_commentaries com, catalogs_comment_types typ
               WHERE com.comment_type_id = typ.id
                 AND com.budget_id =".concat(budget_id.to_s) +
                " AND typ.abbr ".concat(lv_autorizacion)

     @commentary_aut01 = RequestsAdministration::Commentary.find_by_sql(lv_sql)
     if @commentary_aut01.empty?
        r = false #SI NO existe NO PUEDE EDITAR, ya que
     end
     r
   end


end
