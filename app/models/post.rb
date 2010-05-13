class Post < ActiveRecord::Base
  validates_presence_of :title, :body, :user_id
  
  belongs_to :user
  
  scope :published, where("published_on <= ?", Date.today)
  scope :unpublished, where("published_on > ?", Date.today)
  scope :latest, published.order("published_on desc")

  acts_as_taggable
  
  def self.search(params)
    posts = Post.latest.limit(10).includes(:tags, :user)
    posts = posts.offset(params[:offset].to_i) if params[:offset]
    posts = posts.where(:tags => {:name => params[:tag]}) if params[:tag]
    posts = posts.where(:user_id => params[:user]) if params[:user]
    posts
  end

end
