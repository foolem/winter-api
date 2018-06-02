class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_current_user
    User.current = current_user
  end

  protected

  def configure_permitted_parameters
    attributes = [:name, :sex, :sex_preference, :birthday, :about, :location_id, :registration]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end

end
