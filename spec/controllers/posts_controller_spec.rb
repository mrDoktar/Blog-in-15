require 'spec_helper'

describe PostsController do

  before do
    @post = Factory :post, :reviewed => false
  end
  
  describe "as admin" do
    before do
      CASClient::Frameworks::Rails::Filter.stub(:filter)
      controller.stub(:current_user).and_return(Factory.build :admin)
    end
    
    it "should be able to visit the show page for an unpublished post" do
      get :show, :id => @post.id
      response.should render_template(:show)
    end
  end
  
  describe "as guest" do
    it "should not be able to visit the show page for an unpublished post" do
      get :show, :id => @post.id
      response.should redirect_to(root_url)
    end
  end
end
