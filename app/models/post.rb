class Post < ActiveRecord::Base
  validates_presence_of :title, :intro, :body, :user_id, :published_on
  
  belongs_to :user
  
  scope :published, where("posts.published_on <= ? AND posts.reviewed = ?", Date.today, true)
  scope :unpublished, where("posts.published_on > ? || posts.reviewed = ?", Date.today, false)
  scope :latest, published.order("posts.published_on desc")

  acts_as_taggable

  def self.with_status(status)
    case status
      when "published" then published
      when "reviewed" then unpublished.where(:reviewed => true)
      when "unfinished" then unpublished.where(:reviewed => false)
    end
  end
  
  def self.search(params, admin = false)
    if admin
      posts = Post.order("posts.published_on DESC").includes(:tags, :user)
    else
      posts = Post.latest.limit(10).includes(:tags, :user)
    end
    posts = posts.offset(params[:offset].to_i) if params[:offset]
    posts = posts.tagged_with(params[:tag]) if params[:tag]
    posts = posts.with_status(params[:status]) if params[:status]
    posts = posts.where(:user_id => params[:user]) if params[:user]
    posts
  end
  
  def status
    if published_on <= Date.today && reviewed
      return "published"
    elsif reviewed 
      return "reviewed"
    else
      return "unfinished"
    end
  end

end
