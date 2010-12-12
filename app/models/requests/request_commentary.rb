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

end
