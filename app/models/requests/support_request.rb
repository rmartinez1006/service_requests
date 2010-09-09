class Requests::SupportRequest < ActiveRecord::Base

  belongs_to :ubication, :class_name => 'Catalogs::Ubication'
  belongs_to :userhelper, :class_name => "Administration::User", :foreign_key => "helper_id"
  belongs_to :requests_status, :class_name => "Catalogs::RequestStatus", :foreign_key => "status_id"


  def before_save
    if  self.request_no == nil
      self.request_no = request_number
    end
    if self.status_id == nil
      self.status_id= 1
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

  def atiende
    

    if self.helper_id == nil
       r = '...'
    else
      r=self.userhelper.name
    end          
    r
  end

  def request_number
    return Time.now
  end
end
