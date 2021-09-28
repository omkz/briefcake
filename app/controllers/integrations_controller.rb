class IntegrationsController < ApplicationController
  before_action :authenticate_user!
  layout "dashboard"

  def create
    respond_to do |format|
      if current_user.update(integrations_params)
        format.html { redirect_to integrations_url, notice: 'Integrations configuration was saved.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def integrations_params
    params.require(:user).permit(:pocket)
  end
end
