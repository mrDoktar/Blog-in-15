class User < ActiveRecord::Base
  has_many :posts
  
  scope :admins, where(:admin => true)
  scope :writers, select("DISTINCT users.*").joins("RIGHT JOIN posts ON posts.user_id = users.id")
end
