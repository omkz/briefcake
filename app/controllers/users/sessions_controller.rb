# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  layout "layouts/devise"

  def destroy
    MIXPANEL.track(current_user.id, 'Sign Out', {
      '$email' => current_user.email
    } )
    super
  end
end
