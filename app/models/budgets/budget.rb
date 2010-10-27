class Budgets::Budget < ActiveRecord::Base
  belongs_to :request, :class_name => "Requests::SupportRequest", :foreign_key => "request_id"
  
  attr_accessor :support_type_id
  
end
