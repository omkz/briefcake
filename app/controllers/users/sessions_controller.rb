# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  layout "briefcake/application"

  after_action only: :destroy do
    session[:has_seen_briefcake] = true
  end

end
