class PagesController < ApplicationController
  def stats
    render plain: "#{User.count},#{Feed.count},#{SentEmail.count}"
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
end
