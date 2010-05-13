class User < ActiveRecord::Base
  has_many :posts
  
  scope :admins, where(:admin => true)
  scope :writers, joins("RIGHT JOIN posts ON posts.user_id = users.id").group(:user_id)
end
