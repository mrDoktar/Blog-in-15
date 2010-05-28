class PostsController < ApplicationController
  
  before_filter :check_if_published, :only => :show

  def index
    @post = Post.latest.first
    @posts = Post.search(params)
    if params[:list]
      render :partial => "listed_post", :collection => @posts.all 
    else
      render "index"
    end
  end
    
  def show
    @posts = Post.latest.limit(10).includes(:tags) - [@post]
  end
  
  private 
  
  def check_if_published
    @post = Post.find_by_id(params[:id])
    redirect_to root_url unless @post.status? :published || current_user.admin?
  end
  
end
