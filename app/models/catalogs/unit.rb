class Catalogs::Unit < ActiveRecord::Base
  validates :abbr,  :presence => true, :length => {:minimum => 3, :maximum => 6}, :uniqueness => true
  validates :name,  :presence => true

  has_many :ubications, :class_name => 'Catalogs::Ubication'
end
