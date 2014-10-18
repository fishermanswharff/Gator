class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) << :username
    devise_parameter_sanitizer.for(:sign_in) << :firstname
    devise_parameter_sanitizer.for(:sign_in) << :lastname
    devise_parameter_sanitizer.for(:sign_in) << :avatar
    devise_parameter_sanitizer.for(:account_update) << :username
    devise_parameter_sanitizer.for(:account_update) << :firstname
    devise_parameter_sanitizer.for(:account_update) << :lastname
    devise_parameter_sanitizer.for(:account_update) << :avatar
  end
end
