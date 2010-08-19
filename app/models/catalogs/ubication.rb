class Catalogs::Ubication < ActiveRecord::Base
  validates :abbr,  :presence => true, :length => {:minimum => 3, :maximum => 6}, :uniqueness => true
  validates :name,  :presence => true
  validates :unit_id, :presence => true

  belongs_to :unit, :class_name => 'Catalogs::Unit'
end
