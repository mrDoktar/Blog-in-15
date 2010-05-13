class User < ActiveRecord::Base
  has_many :posts
  
  scope :admins, where(:admin => true)
end
