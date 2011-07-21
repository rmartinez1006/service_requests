class Budgets::Budget < ActiveRecord::Base
  belongs_to :request, :class_name => "RequestsAdministration::SupportRequest", :foreign_key => "support_request_id"
  belongs_to :supplier, :class_name => "Catalogs::Supplier", :foreign_key => "supplier_id"
  belongs_to :user, :class_name => "Administration::User", :foreign_key => "user_id"


  has_many :supply, :class_name => 'Budgets::BudgetSupply',:foreign_key => "budget_id"

  attr_accessor :support_type_id, :tech_description, :description_supply,
                :mat_unit, :mat_description, :mat_quantity, :mat_cost, :mat_import, :mat_type, :mat_other,
                :work_unit, :work_description, :work_quantity, :work_cost, :work_import, :work_type, :work_other,
                :add_aut_analista, :add_aut_02, :add_aut_03, :add_aut_04,:add_aut_05, :chk_analista, :chk_aut_02, 
                :chk_aut_03, :chk_aut_04, :chk_aut_05, :chk_instruc, :add_instruc, :add_comment, :add_instruc

include Common


#validates_format_of :total_cost, :with => /\d{0,10}\./
# validates_format_of :total_cost, :with => /\d{0,10}\.\d{2}/
validates_numericality_of :total_cost,  :message => "Debe ser númerico."
validates_numericality_of :unit_cost,  :message => "Debe ser númerico."
validates_numericality_of :quantity,  :message => "Debe ser númerico."

HUMANIZED_ATTRIBUTES = {
    :total_cost    => 'Costo',
    :unit_cost   => 'Costo Unitario',
    :quantity => 'Cantidad',
    :ending_date => 'Fecha de Término',
    :order_num=> 'Número de Orden'
  }

  def self.human_attribute_name(attr, options={})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end


  def before_destroy
    # Borrar todos los comentarios de este presupuesto
    RequestsAdministration::Commentary.destroy_all :budget_id => self.id
  end

  def before_save
    lv_user_id = Administration::UserSession.find.record.attributes['id']
    if  self.budget_date == nil
      self.budget_date = Time.now
      self.user_id = lv_user_id
    end

#    if self.total_cost <= 0
#      self.errors.add(:total_cost, 'El costo total debe ser numerico mayor de cero.' )
#      raise "error"
#    end

  end


  def after_save
    unless self.support_request_id == nil
#       Obtene clave de estatus "ST07"
        @status_req = Catalogs::RequestStatus.find(:first, :conditions => "abbr = 'ST07'")
        lv_status_id = @status_req.id
        self.request.support_type_id
#       Actuself.support_request_idalizar la descripción Tecnica y Tipo de Soporte
        @requests_support_request = RequestsAdministration::SupportRequest.find(self.support_request_id)
        @requests_support_request.tech_description = self.tech_description
        if self.support_type_id == nil
           @requests_support_request.support_type_id = self.request.support_type_id
        else
           @requests_support_request.support_type_id = self.support_type_id
        end
        @requests_support_request.request_status_id = lv_status_id
        @requests_support_request.save
    end

  end


#Obtener el total de los materiales o mano de obra
 def suma_total(budgets_supplies)
   sum = 0
   for item in budgets_supplies
     sum = sum + item.unit_cost * item.quantity
   end
   sum
 end


   #-- devuelve true si existe la autorización
   def valida_budget_aut(budget_id)
     r = true #Tiene permiso para EDITAR

     # Si existe la autorizacion 1, el ANALISTA ya no puede editar
     lv_role = Administration::UserSession.find.record.attributes['role']
     if lv_role == 'APRE'
        lv_autorizacion ="='AUT-P01'"
     end


     # Si esta pendiente la autorizacion 3  no se puede Editar el presupuesto
     if (lv_role == 'COORD') |  (lv_role == 'ADMIN')
       lv_autorizacion = " ='AUT-P03'"
     end


     if lv_autorizacion == nil
       r = false
       return
     end

     lv_numaut = get_num_aut(budget_id)

     lv_sql ="SELECT * FROM request_commentaries com, catalogs_comment_types typ
               WHERE com.comment_type_id = typ.id
                 AND com.budget_id =".concat(budget_id.to_s) +
                " AND typ.abbr ".concat(lv_autorizacion)

     @commentary_aut01 = RequestsAdministration::Commentary.find_by_sql(lv_sql)
     if @commentary_aut01.empty?
        r = false #SI NO existe NO PUEDE EDITAR, ya que
     end
     r
   end

   def fn_ending_date(lv_date)
     r =''
     if lv_date != nil
      r = lv_date.strftime("%d/%m/%Y")
     end
     r
   end


def num2letra(numero)
  de_tres_en_tres = numero.to_i.to_s.reverse.scan(/\d{1,3}/).map{|n| n.reverse.to_i}

  millones = [
    {true => nil, false => nil},
    {true => 'millón', false => 'millones'},
    {true => "billón", false => "billones"},
    {true => "trillón", false => "trillones"}
  ]

  centena_anterior = 0
  contador = -1
  palabras = de_tres_en_tres.map do |numeros|
    contador += 1
    if contador%2 == 0
      centena_anterior = numeros
      [centena_a_palabras(numeros), millones[contador/2][numeros==1]].compact if numeros > 0
    elsif centena_anterior == 0
      [centena_a_palabras(numeros), "mil", millones[contador/2][false]].compact if numeros > 0
    else
      [centena_a_palabras(numeros), "mil"] if numeros > 0
    end
  end

  r= palabras.compact.reverse.join(' ')

  r.upcase.concat(" PESOS ") << (numero.to_s.split(".")[1]).slice(0,2).ljust(2,'0')<< "/100 M.N."

end

def centena_a_palabras(numero)
  especiales = {
    11 => 'once', 12 => 'doce', 13 => 'trece', 14 => 'catorce', 15 => 'quince',
    10 => 'diez', 20 => 'veinte', 100 => 'cien'
  }
  if especiales.has_key?(numero)
    return especiales[numero]
  end

  centenas = [nil, 'ciento', 'doscientos', 'trescientos', 'cuatrocientos', 'quinientos', 'seiscientos', 'setecientos', 'ochocientos', 'novecientos']
  decenas = [nil, 'dieci', 'veinti', 'treinta', 'cuarenta', 'cincuenta', 'sesenta', 'setenta', 'ochenta', 'noventa']
  unidades = [nil, 'un', 'dos', 'tres', 'cuatro', 'cinco', 'seis', 'siete', 'ocho', 'nueve']

  centena, decena, unidad = numero.to_s.rjust(3,'0').scan(/\d/).map{|i| i.to_i}

  palabras = []
  palabras << centenas[centena]

  if especiales.has_key?(decena*10 + unidad)
    palabras << especiales[decena*10 + unidad]
  else
    tmp = "#{decenas[decena]}#{' y ' if decena > 2 && unidad > 0}#{unidades[unidad]}"
    palabras << (tmp.blank? ? nil : tmp)
  end

  palabras.compact.join(' ')
end


#Obtener el costo sin iva (antes de iva)
 def costo_sin_iva()
   r=0
   if self.total_cost > 0
      r = self.total_cost / 1.16   #16% de iva
      r = "%.2f" % r      
   end
   r
 end

 #Calcular solo iva (16%)
 def solo_iva()
   r=0
   lv_sin_iva = self.costo_sin_iva().to_f
   if lv_sin_iva > 0
      r =  lv_sin_iva.to_f * 0.16   #16% de iva
      r = "%.2f" % r
   end
   r.to_f
 end

#Proveedor
  def supplier_name()
    if  self.supplier.trade_name == nil
      r = "..."
    else
      r=self.supplier.trade_name
    end
  end

#Proveedor Registro Federal del Contribuyente
  def supplier_rfc()
    if  self.supplier.taxpayer_reg == nil
      r = "..."
    else
      r=self.supplier.taxpayer_reg
    end
  end

# Dirección
  def supplier_address()
    if  self.supplier.address == nil
      r = "..."
    else
      r=self.supplier.address
    end

  end

# Persona Fisica (company_name)
  def supplier_responsible()
    if  self.supplier.taxpayer_type == 1
     #PERSONA FISICA
     r = self.supplier.company_name
    end
    if self.supplier.taxpayer_type == 2
      #PERSONA MORAL
      r = self.supplier.trade_name
    end
    r
  end

# Persona 1-Fisica / 2-Moral
  def supplier_type()
    if  self.supplier.taxpayer_type == 1
      r = "PERSONA FISICA"
    end
    if self.supplier.taxpayer_type == 2
      r= "PERSONA MORAL"
    end
    r
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

def display_instruc()
  f = false
  role = Administration::UserSession.find.record.attributes['role']
  if role == 'JEFUNI' or role == 'ADMIN' or role == 'COORD'
     r = true
  end
  r
end


end
