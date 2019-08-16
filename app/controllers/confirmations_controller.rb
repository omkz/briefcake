class ConfirmationsController < Devise::ConfirmationsController
  def confirmed
  end

  private

  def after_confirmation_path_for(resource_name, resource)
    "/confirmed"
  end
end
