class Requests::SupportRequest < ActiveRecord::Base

  belongs_to :ubication, :class_name => 'Catalogs::Ubication'
  
end
