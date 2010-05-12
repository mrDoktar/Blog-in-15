class PostsController < ApplicationController

  def index
    @posts = Post.latest
  end
    
  def show
    @post = Post.find_by_id(params[:id])
    @posts = Post.latest - [@post]
  end
  
end
