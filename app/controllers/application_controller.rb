class ApplicationController < ActionController::Base
 before_action :flash_attack

 def flash_attack
  flash[:attack] = "Loading page"
end
include Pundit

  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
   before_action :configure_permitted_parameters, if: :devise_controller?

   rescue_from Pundit::NotAuthorizedError do |exception|
   redirect_to root_url, alert: exception.message
   end
 
   protected
 
   def configure_permitted_parameters
     devise_parameter_sanitizer.for(:sign_up) << :name
   end
 end

