class Administration::User < ActiveRecord::Base
  acts_as_authentic

#  validates :role_id, :presence => true
#  validates :ubication_id, :presence => true
#  belongs_to :user_role, :class_name => 'UserRole'
  belongs_to :user_role, :foreign_key => "role_id"
  belongs_to :ubication, :class_name => 'Catalogs::Ubication'

#  attr_accessor :password_confirmation
#  validates_confirmation_of :password
#  validates_confirmation_of :password, :if => :new_password?

  

def permiso(id)
    r = false
    # el usuario autentificado puede editar su usuario
    if self.id == id
      r = true
    else
      # Obtener el rol del usuario autentificado
      lv_role = Administration::UserSession.find.record.attributes['role']
#      lv_role_id = Administration::UserSession.find.record.attributes['role_id']
#      lv_role = Administration::UserRole.find(:first, :conditions => "id = " + lv_role_id.to_s)
      if lv_role == 'ADMIN'
        r = true
      end


    end
    r

end


end
