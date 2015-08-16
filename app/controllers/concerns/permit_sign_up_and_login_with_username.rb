module PermitSignUpAndLoginWithUsername
  extend ActiveSupport::Concern

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit devise_sign_up_params }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit devise_sign_in_params }
  end

  def devise_sign_up_params
    [:username, :email, :password, :password_confirmation, :remember_me]
  end

  def devise_sign_in_params
    [:login, :username, :email, :password, :remember_me]
  end
end
