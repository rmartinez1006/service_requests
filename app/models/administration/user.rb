class Administration::User < ActiveRecord::Base

  validates :role_id, :presence => true
  validates :ubication_id, :presence => true
  belongs_to :user_role, :class_name => 'Administration::User_role'
  belongs_to :ubication, :class_name => 'Catalogs::Ubication'

end
