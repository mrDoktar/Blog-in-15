class Post < ActiveRecord::Base
  validates_presence_of :title, :body
  
  scope :published, where("published_on <= ?", Date.today)
  scope :unpublished, where("published_on > ?", Date.today)
  scope :latest, published.order("published_on desc")

  acts_as_taggable
end
