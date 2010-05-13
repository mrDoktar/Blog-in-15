class Admin::PostsController < ApplicationController

  before_filter CASClient::Frameworks::Rails::Filter

  def new
    @post = Post.new
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
