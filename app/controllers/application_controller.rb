class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  helper_method :current_user

  private
  
  def current_user
    return nil unless session[:cas_email].present?
    @current_user ||= User.find_or_create_by_email(session[:cas_email])
  end
  
  def require_admin
    return current_user.present?
  end
  
end
