class ApplicationController < ActionController::Base
  before_action :masquerade_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_payer
    # 'Current' method to refer to for Stripe methods (eg. `.subscription`, etc)
    # Defaults to `current_user`. This is also the class
    # where `include Sjabloon::Stripe` is included (eg. User)
    current_user
  end
  helper_method :current_payer

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
