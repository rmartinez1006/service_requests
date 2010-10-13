class Requests::SupportRequest < ActiveRecord::Base

  
  belongs_to :ubication, :class_name => 'Catalogs::Ubication'
  belongs_to :userhelper, :class_name => "Administration::User", :foreign_key => "helper_id"
  belongs_to :requests_status, :class_name => "Catalogs::RequestStatus", :foreign_key => "status_id"

  belongs_to :supporttype, :class_name => 'Catalogs::SupportType', :foreign_key => 'support_type_id'

  has_many :ubications, :class_name => 'Catalogs::Ubication'
  
  
  

  def before_save
    if  self.request_no == nil
      self.request_no = request_number
    end
    if self.status_id == nil
      self.status_id = 1
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

    if self.id == nil
       r = '---'
    else
      r=self.ubication.unit.abbr + '-' + "%04d" % self.id.to_s + '-' +
        self.created_at.strftime("%Y")
    end
    r
  end




  def request_number
    return Time.now
  end

 def img_status(status)
    if status == 1 or estado = nil
      return "ST01.png"
    else
      if status == 2
        return "ST02.png"
      else
        return "ST03.png"
      end
    end
  end

end
