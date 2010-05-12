require 'spec_helper'

describe Admin::PostsController do
  before do
    @user = mock("User", :email => "john.doe@example.com")
    @post = mock_model(Post, :null_object => true)
    Post.stub(:find_by_id).and_return(@post)    
  end
  
  describe "as admin" do
    before do
      CASClient::Frameworks::Rails::Filter.stub(:filter).and_return(true)
    end
    
    it "should be able to visit the new page" do
      get :new
      response.should render_template(:new)
    end
    
    it "should be able to use the create action" do
      post :create
      response.should render_template(:new)
    end
    
    it "should be able to visit the edit page" do
      get :edit, :id => 1
      response.should render_template(:edit)
    end
    
    it "should be able to use the update action" do
      put :update, :id => 1
      response.should redirect_to(post_path(@post))    
    end
    
    it "should be able to use the destroy action" do
      delete :destroy, :id => 1
      response.should redirect_to(posts_path)
    end
  end
  
  describe "as guest" do
    
    it "should not be able to visite the new page" do
      get :new
      response.should_not render_template(:new)
    end

    it "should not be able to use the create action" do
      post :create
      response.should_not render_template(:new)
    end
    
    it "should not be able to visit the edit page" do
      get :edit, :id => 1
      response.should_not render_template(:edit)
    end
    
    it "should not be able to use the update action" do
      put :update, :id => 1
      response.should_not redirect_to(post_path(@post))    
    end
    
    it "should not be able to use the destroy action" do
      delete :destroy, :id => 1
      response.should_not redirect_to(posts_path)
    end

  end 
end
