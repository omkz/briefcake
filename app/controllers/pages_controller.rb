class PagesController < ApplicationController
  layout "briefcake/application", only: [:home, :creators, :plans]
  def stats
    render plain: "#{User.count},#{Feed.count},#{SentEmail.count},#{User.where(is_pro: true).count}"
  end

  def example
    render layout: "mailer"
  end

  def subscribe
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

  def about
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

end
