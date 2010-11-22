class RequestsAdministration::Commentary < ActiveRecord::Base
  belongs_to :request, :class_name => "RequestsAdministration::SupportRequest", :foreign_key => "support_request_id"
  belongs_to :user, :class_name => "Administration::User", :foreign_key => "user_id"

  # Convertir Texto a formato html
def valida_comentario (text)
  if text == nil
     r = '..'
  else
     r = text.gsub(/\n/, "<br />")
  r
  end
end


end
