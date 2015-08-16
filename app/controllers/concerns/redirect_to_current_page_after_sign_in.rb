module RedirectToCurrentPageAfterSignIn
  extend ActiveSupport::Concern

  def authenticate_user!(opts = {})
    unless opts || user_signed_in? || devise_controller? || !redirectable?
      store_location_for(:user, request.fullpath)
    end
    super(opts)
  end

  def redirectable?
    request.get? && !request.xhr? && is_navigational_format?
  end
end
