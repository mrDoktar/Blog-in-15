require 'spec_helper'

describe Post do

  before do
    @admin = Factory :admin
    @valid_attributes = {
      :title => "My blog title",
      :intro => "An intro",
      :body => "Some content",
      :published_on => Date.today,
      :reviewed => true,
      :user_id => @admin.id
    }
  end
  
  it "should require a title" do
    Post.new(@valid_attributes.except(:title)).should_not be_valid
  end

  it "should require an intro" do
    Post.new(@valid_attributes.except(:intro)).should_not be_valid
  end

  
  it "should require a body" do
    Post.new(@valid_attributes.except(:body)).should_not be_valid
  end

  describe "calling scopes" do
    before do
      @post1 = Factory :post, :published_on => 4.days.ago
      @post2 = Factory :post, :published_on => 2.days.ago
      @post3 = Factory :post, :published_on => Date.today, :reviewed => false
      @post4 = Factory :post, :published_on => 2.days.from_now
    end
    
    it "should return published posts that are reviewd" do
      Post.published.should have(2).post
    end
    
    it "should return unpublished posts" do
      Post.unpublished.first.should eql(@post4)
    end
    
    it "should return the latest posts sorted by published date" do
      posts = Post.latest
      posts.first.should eql(@post2)
      posts.last.should eql(@post1)
    end
    
  end
end
