class PagesController < ApplicationController
  layout "briefcake/application", only: [:home, :creator, :plans, :privacy_policy, :terms_of_service, :cookie_policy]

  def example
    response.headers["X-FRAME-OPTIONS"] = "ALLOWALL"
    render layout: "mailer"
  end

  def plans
    respond_to do |format|
      if current_user
        format.html { render layout: 'dashboard' }
      else
        format.html 
      end
    end
  end

  def thankyou
  end
end
