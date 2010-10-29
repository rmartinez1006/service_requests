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
  
end
