class PostsController < ApplicationController

  def index
    @posts = Post.scoped
    @posts = @posts.latest.limit(20).includes(:tags)
    @posts = @posts.offset(params[:offset].to_i) if params[:offset]
    render :partial => "listed_post", :collection => @posts.all if params[:list]
  end
    
  def show
    @post = Post.find_by_id(params[:id])
    @posts = Post.latest.limit(20).includes(:tags) - [@post]
  end
  
end
