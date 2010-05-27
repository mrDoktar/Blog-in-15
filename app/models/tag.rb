class Tag < ActiveRecord::Base
  scope :published, joins("RIGHT JOIN taggings ON taggings.tag_id = tags.id RIGHT JOIN posts ON posts.id = taggings.taggable_id AND taggings.taggable_type = 'Post'") & Post.published
end
