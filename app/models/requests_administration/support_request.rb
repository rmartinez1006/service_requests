class RequestsAdministration::SupportRequest < ActiveRecord::Base
  include Common
  
  belongs_to :ubication, :class_name => 'Catalogs::Ubication'
  belongs_to :userhelper, :class_name => "Administration::User", :foreign_key => "helper_id"
  belongs_to :requests_status, :class_name => "Catalogs::RequestStatus", :foreign_key => "status_id"
  belongs_to :supporttype, :class_name => 'Catalogs::SupportType', :foreign_key => 'support_type_id'

#  has_many :ubications, :class_name => 'Catalogs::Ubication'

  has_many :reqdelegation, :class_name => 'Requests::ReqDelegation'
  has_many :commentary, :class_name => 'Requests::RequestCommentary'
  
  attr_accessor :commentaries_to_add, :notify,:req_ubication

  validates :commentaries_to_add, :presence => true, :on => :show

#HUMAN_ATTRIBUTES = {
#    :commentaries_to_add => 'Comentario.',
#    :req_ubication => 'Ubicación',
#    :notify => 'Notificar.'
#  }

  def before_save
    if  self.request_no == nil
      self.request_no = request_number
    end
    if self.request_status_id == nil
      self.request_status_id = 1
#      self.helper_id = 2
      self.status_chng_date=Time.now
    end
  end

  def description_left(l)
    r=self.description
    if r.length > l
      r= r.to(l-3)+'...'
    end
    r
  end


# Validar Helper (Atiende)
  def helper
    
    if self.helper_id == nil
       r = '---'
    else
      r=self.userhelper.name
    end          
    r
  end

# Validar SupportType (Tipo de Soporte)
  def support_type

    if self.support_type_id == nil
       r = '---'
    else
      r=self.supporttype.name
    end
    r
  end

# No. de Folio
  def num_sequence

    if self.ubication_id == nil
       lv_unit = '????'
    else
       lv_unit = self.ubication.unit.abbr    
    end
    
    if self.id == nil
       r = '---'
    else
      r= lv_unit + '-' + "%04d" % self.id.to_s + '-' +
        self.created_at.strftime("%y")
    end
    r
  end

# Descripcion de la ubicación
def ubication_name
  if self.ubication_id == nil
     r = '--'
  else
     r = self.ubication.name
  r
  end
end  

# Descripcion Fisica de la ubicación
def request_ubication (ubication)
  if ubication == nil
     r = '--'
  else
     r = ubication.gsub(/\n/, "<br />")

  self.req_ubication = r
  r
  end
end

# No. de solicitud
  def request_number
    return Time.now
  end


 def img_status(status)

    r = get_status_abbr(status)
    return r+'.png'

    #if status == 1 or status == nil
    #  return "ST01.png"
    #end

    #if status == 2
    #    return "ST02.png"
    #end

    #if status == 7
    #    return "ST07.png"
    #end

  end

# Convertir Texto a formato html
def text_to_html (text1)
  if text1 == nil
     r = '--'
  else
     r = text1.gsub(/\n/, "<br />")
  r
  end
end
 

# Validación para determinar activar el link de escalar
  def valida_escalar
    user_id = Administration::UserSession.find.record.attributes['id']
    id_req= self.id
    r = false
#   Si no esta asignado un responsable: Se puede escalar
    if self.helper_id == nil
       r = true
    else
#     Si es el usuario actual(de la sesion) es el que esta asigando para su atención
      if self.helper_id == user_id
         r = true
      end
    end
  end


# Validación para determinar activar el link de Presupesto
# Si no existe presupuesto, entonces, activar el link, si existe no activar
  def valida_presupuesto(req_id)
    @budget = Budgets::Budget.find(:all, :conditions => "support_request_id = " + req_id.to_s)
    r = true
#   Si NO EXISTE (Se puede crear)
    if @budget.size >0
       r = false
    end
    r
  end

  # Valida el rol para determinar si tiene permisos
  def valida_rol
    lv_exito = false
    r = Administration::UserSession.find.record.attributes['role']
    # Si es administrador o Analista Prsupuestador
    if (r == 'ADMIN' or r== 'APRE' or r=='JEFUNI' or r=='COORD')
      lv_exito = true
    end
    lv_exito
  end


end
