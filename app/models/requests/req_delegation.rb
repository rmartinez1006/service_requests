class Requests::ReqDelegation < ActiveRecord::Base
   belongs_to :user, :class_name => "Administration::User", :foreign_key => "user_id"
   belongs_to :userhelper, :class_name => "Administration::User", :foreign_key => "helper_id"
   belongs_to :request, :class_name => "Requests::SupportRequest", :foreign_key => "request_id"

end
