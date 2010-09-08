class Administration::UserHierachy < ActiveRecord::Base
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  belongs_to :userhelper, :class_name => "User", :foreign_key => "helper_id"
end
