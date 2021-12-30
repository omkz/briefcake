# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :detect_bot, only: [:new, :create]
  before_action :configure_account_update_params, only: [:update]
  layout :set_layout

  after_action -> { MIXPANEL.track(current_user.id, 'Sign up', { '$email' => current_user.email }) }, only: [:create]

  def configure_account_update_params
    params[:user][:send_email_at] = [
      params[:user]["send_email_at(4i)"],
      params[:user]["send_email_at(5i)"]
    ].join(":")

    params[:user].delete("send_email_at(4i)")
    params[:user].delete("send_email_at(5i)")

    devise_parameter_sanitizer.permit(:account_update, keys: [:send_email_at, :time_zone])
  end



  def destroy
    super do |user|
      # do an extra destroy to actually delete it after the soft delete
      user.destroy
    end
  end

  protected

  def after_update_path_for(resource)
    edit_user_registration_path
  end

  def update_resource(resource, params)
    resource.update_without_password(params.except(:current_password))
  end

  def detect_bot
    render body: "Bots may not sign up" and return if browser.bot?
  end

  def set_layout
    case action_name
    when "edit"
      "dashboard"
    else
      "layouts/devise"
    end
  end
end
