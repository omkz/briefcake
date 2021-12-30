# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  layout "layouts/devise"

  def create
    MIXPANEL.track(current_user.id, 'Sign In', {
      '$email' => current_user.email
    } )
    super
  end

  def destroy
    MIXPANEL.track(current_user.id, 'Sign Out', {
      '$email' => current_user.email
    } )
    super
  end
end
