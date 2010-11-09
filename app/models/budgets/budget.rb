class Budgets::Budget < ActiveRecord::Base
  belongs_to :request, :class_name => "Requests::SupportRequest", :foreign_key => "request_id"
  belongs_to :supplier, :class_name => "Catalogs::Supplier", :foreign_key => "supplier_id"
# belongs_to :supplier, :class_name => 'Catalogs::Supplier'
  
  attr_accessor :support_type_id, :tech_description, :description_supply

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
    unless self.request_id == nil
#       Obtene clave de estatus "ST07"
        @status_req = Catalogs::RequestStatus.find(:first, :conditions => "abbr = 'ST07'")
        lv_status_id = @status_req.id
#       Actuself.request_idalizar la descripción Tecnica y Tipo de Soporte
        @requests_support_request = Requests::SupportRequest.find(self.request_id)
        @requests_support_request.tech_description = self.tech_description
        @requests_support_request.support_type_id = self.support_type_id
        @requests_support_request.status_id = lv_status_id
        @requests_support_request.save
    end

  end
  
end
