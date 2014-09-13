class ApplicationController < ActionController::Base

  include PublicActivity::StoreController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  #helper_method :publicadors?
  protected

  #def publicadors?
  #  false
  #end

  #def authorize
  #  unless publicadors?
  #    flash[:error] = "Acceso denegado"
  #    redirect_to root_path
   #   false
  #end

  #Damos acceso a devise a los datos necesarios para logearse, registrarse y updatear la cuenta
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :nombre, :ciudad_id, :region_id , :email, :password, :password_confirmation, :remember_me, :direccion) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :nombre, :ciudad_id, :region_id , :email, :password, :remember_me, :current_password) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:nombre, :ciudad_id, :region_id , :email, :password, :password_confirmation, :current_password, :ranking, :foto) }
  end
    
end
