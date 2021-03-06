class Admin::PostsController < ApplicationController
  before_filter CASClient::Frameworks::Rails::Filter
  before_filter :require_admin

  def index
    @posts = Post.search(params, true)
    if params[:list]
      render @posts.all 
    else
      render "index"
    end    
  end

  def new
    @post = Post.new
    @tags = Tag.order(:name)
  end
  
  def create
    @post = Post.new(params[:post])
    @post.user = current_user
    if @post.save
      redirect_to post_url @post
    else
      render "new"
    end
  end
  
  def edit
    @post = Post.find_by_id(params[:id])
    @tags = Tag.order(:name)
  end
  
  def update
    @post = Post.find_by_id(params[:id])

    if @post.update_attributes(params[:post])
      redirect_to post_url @post
    else
      render "edit"
    end
  end
  
  def destroy
    @post = Post.find_by_id(params[:id])
    @post.destroy unless @post.nil?
    redirect_to posts_url
  end
  
end
