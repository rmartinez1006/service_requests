class Budgets::Budget < ActiveRecord::Base
  belongs_to :request, :class_name => "Requests::SupportRequest", :foreign_key => "request_id"
  belongs_to :supplier, :class_name => "Catalogs::Supplier", :foreign_key => "supplier_id"
# belongs_to :supplier, :class_name => 'Catalogs::Supplier'
  
  attr_accessor :support_type_id, :tech_description


  def before_save
    lv_user_id = Administration::UserSession.find.record.attributes['id']
    if  self.budget_date == nil
      self.budget_date = Time.now
      self.user_id = lv_user_id
    end
  end


  def after_save
    unless self.request_id == nil
#      Actuself.request_idalizar la descripción Tecnica y Tipo de Soporte
        @requests_support_request = Requests::SupportRequest.find(self.request_id)
        @requests_support_request.tech_description = self.tech_description
        @requests_support_request.support_type_id = self.support_type_id
        @requests_support_request.save

    end

  end
  
end
