class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :devise_permit_params, if: :devise_controller?
  def after_sign_up_path_for(resource)
    user_path(resource)
  end
  def after_sign_in_path_for(resource)
    user_path(resource)
  end
  def devise_permit_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end
