class RequestsAdministration::Commentary < ActiveRecord::Base
  belongs_to :request, :class_name => "Requests::SupportRequest", :foreign_key => "request_id"
  belongs_to :user, :class_name => "Administration::User", :foreign_key => "user_id"
end
