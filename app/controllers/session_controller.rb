class SessionController < ApplicationController
    before_filter CASClient::Frameworks::Rails::Filter, :only => :login
  
  def logout
    @current_user = nil
    reset_session
    CASClient::Frameworks::Rails::Filter.logout(self, root_url) and return
  end
  
  def login
    redirect_to root_url
  end
end
