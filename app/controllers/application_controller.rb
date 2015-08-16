class ApplicationController < ActionController::Base
  include PermitSignUpAndLoginWithUsername
  include RedirectToCurrentPageAfterSignIn

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :layout_by_access

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def layout_by_access
    if devise_controller?
      'devise'
    else
      'application'
    end
  end
end
