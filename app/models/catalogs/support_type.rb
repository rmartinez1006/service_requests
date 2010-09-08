class Catalogs::SupportType < ActiveRecord::Base
  validates :abbr,  :presence => true, :length => {:minimum => 3, :maximum => 6}, :uniqueness => true
  validates :name,  :presence => true
end
