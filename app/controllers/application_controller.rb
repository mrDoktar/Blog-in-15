class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  helper_method :current_user

  private
  
  def current_user
    return nil unless session[:cas_email].present?
    session[:cas_email] += "@gmail.com" unless(session[:cas_email].include? "@")
    @current_user ||= User.find_or_create_by_email(session[:cas_email])
  end
  
  def require_admin
    redirect_to root_url unless current_user.present? && current_user.admin
  end
  
end
