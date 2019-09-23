# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:update]

  def configure_account_update_params
    params[:user][:send_email_at] = [
      params[:user]["send_email_at(4i)"],
      params[:user]["send_email_at(5i)"]
    ].join(":")

    params[:user].delete("send_email_at(4i)")
    params[:user].delete("send_email_at(5i)")

    devise_parameter_sanitizer.permit(:account_update, keys: [:send_email_at, :time_zone])
  end

  protected

  def after_update_path_for(resource)
    edit_user_registration_path
  end

  def update_resource(resource, params)
    resource.update_without_password(params.except(:current_password))
  end
end
