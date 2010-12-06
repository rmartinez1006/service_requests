class Post < ActiveRecord::Base
  attr_accessible :title, :content

  validates_presence_of :title, :content
end
