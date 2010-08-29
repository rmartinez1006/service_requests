class Administration::User < ActiveRecord::Base

  validates :role_id, :presence => true
  validates :ubication_id, :presence => true
#  belongs_to :user_role, :class_name => 'UserRole'
  belongs_to :user_role, :foreign_key => "role_id"
  belongs_to :ubication, :class_name => 'Catalogs::Ubication'

  attr_accessor :password_confirmation
  validates_confirmation_of :password
#  validates_confirmation_of :password, :if => :new_password?



end
