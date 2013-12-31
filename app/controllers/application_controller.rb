class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_locale
  
  def set_locale
    if user_signed_in?
      if params[:locale]
        I18n.locale = params[:locale]
        current_user.locale = I18n.locale
        current_user.save      
      elsif current_user.locale.nil?
        I18n.locale = (session[:locale] || I18n.default_locale)
        current_user.locale = I18n.locale
        current_user.save
      end 
      I18n.locale = current_user.locale
    else    
      I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
    end    
    session[:locale] = I18n.locale
  end
  
  protected
  
  def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :screenname
      devise_parameter_sanitizer.for(:account_update) << :screenname    
  end
  
  
end
