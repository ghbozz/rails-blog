class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    # devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password) }
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password])
  end
end
