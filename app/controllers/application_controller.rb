# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  # helper_method :authorize_admin

  def authorize_admin
    redirect_to root_path unless current_user.try(:admin?)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i(first_name last_name
                                                         phone admin))
    devise_parameter_sanitizer.permit(:account_update, keys: %i(first_name
                                                                last_name phone
                                                                admin))
  end
end
