class PagesController < ApplicationController
  layout "briefcake/application", only: [:home, :creator, :plans, :privacy_policy, :terms_of_service, :cookie_policy]
  layout "dashboard", only: [:browser]

  def privacy_policy
  end

  def browser
  end

  def terms_of_service
  end

  def stats
    render plain: "#{User.count},#{Feed.count},#{SentEmail.count},#{User.where(is_pro: true).count}"
  end

  def example
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

  def home
  end

  def creator
  end

end
