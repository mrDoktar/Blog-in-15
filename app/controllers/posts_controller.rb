class PostsController < ApplicationController

  def index
    @posts = Post.search(params)
    if params[:list]
      render :partial => "listed_post", :collection => @posts.all 
    else
      render "index"
    end
  end
    
  def show
    @post = Post.find_by_id(params[:id])
    @posts = Post.latest.limit(10).includes(:tags) - [@post]
  end
  
end
