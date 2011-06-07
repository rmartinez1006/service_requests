class Catalogs::Ubication < ActiveRecord::Base
  validates :abbr,  :presence => true, :length => {:minimum => 3, :maximum => 6}, :uniqueness => true
  validates :name,  :presence => true
  validates :unit_id, :presence => true

  belongs_to :unit, :class_name => 'Catalogs::Unit'

#  attr_accessor :available_list,:available_once



#  def before_save
#    self.available = self.available_once
#    if !self.available_list.empty?
#      self.available = self.available_list
#    end
#  end

end
