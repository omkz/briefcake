class PagesController < ApplicationController
  def stats
    render plain: "#{User.count},#{Feed.count},#{SentEmail.count},#{User.where(is_pro: true).count}"
  end

  def example
    render layout: "mailer"
  end

  def subscribe
  end

  def plans
  end

  def thankyou
  end

  def home
  end
end
