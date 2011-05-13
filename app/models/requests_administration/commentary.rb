class RequestsAdministration::Commentary < ActiveRecord::Base
  belongs_to :request, :class_name => "RequestsAdministration::SupportRequest", :foreign_key => "support_request_id"
  belongs_to :user, :class_name => "Administration::User", :foreign_key => "user_id"

  include Common
  
# Convertir Texto a formato html
def valida_comentario (text)
  if text == nil
     r = '..'
  else
     r = text.gsub(/\n/, "<br />")
  r
  end
end

 # Verificar el usuario que emite el comentario
 def verifica_usuario(user_id)
   if self.user_id == 0
     r = 'SOLICITANTE'
   else
     r= self.user.name
   end
 end

end