class Requests::RequestCommentary < ActiveRecord::Base
  self.table_name = 'request_commentaries'  #Nombre de la tabla
  belongs_to :request, :class_name => "Requests::SupportRequest", :foreign_key => "request_id"
  belongs_to :user, :class_name => "Administration::User", :foreign_key => "user_id"

# Convertir Texto a formato html
def valida_comentario (text)
  if text == nil
     r = '..'
  else
     r = text.gsub(/\n/, "<br />")
  end
  r
end

 # Verificar el usuario que emite el comentario
 def verifica_usuario(user_id)
   if self.user_id == 0
     @request_support_requests = Requests::SupportRequest.find(self.support_request_id)
     unless  @request_support_requests == nil
        r = @request_support_requests.name
     else
        r = 'SOLICITANTE'
     end

     
   else
     r= self.user.name
   end
   r
 end

end
