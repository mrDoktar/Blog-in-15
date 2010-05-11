class PostsController < ApplicationController
  
  def index
    @posts = Post.latest
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(params[:post])
    if @post.save
      redirect_to @post
    else
      render "new"
    end
  end
  
  def show
    @post = Post.find_by_id(params[:id])
    @posts = Post.latest - [@post]
  end
  
  def edit
    @post = Post.find_by_id(params[:id])
  end
  
  def update
    @post = Post.find_by_id(params[:id])

    if @post.update_attributes(params[:post])
      redirect_to @post
    else
      render "edit"
    end
  end
  
  def destroy
    @post = Post.find_by_id(params[:id])
    @post.destroy unless @post.nil?
    redirect_to posts_path
  end
  
end
