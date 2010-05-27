class LogoutController < ApplicationController
  def logout
    @current_user = nil
    reset_session
    CASClient::Frameworks::Rails::Filter.logout(self, root_url) and return
  end
end
