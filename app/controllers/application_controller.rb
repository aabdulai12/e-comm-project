class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :initialize_session
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Initialize session for cart
  def initialize_session
    session[:cart] ||= []
    @cart_products = Product.where(id: session[:cart])
  end

  # Permit additional parameters for Devise
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[address city province_id])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[address city province_id])
  end
end
