class Administration::User < ActiveRecord::Base

  validates :role_id, :presence => true
  belongs_to :user_role, :class_name => 'Administration::User_role'



end
