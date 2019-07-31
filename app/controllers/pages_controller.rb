class PagesController < ApplicationController
  def stats
    render plain: "#{User.count},#{Feed.count},#{SentEmail.count}"
  end

  def example
    @feed_items = SampleContent.items
    render "user_mailer/new_items", layout: "mailer"
  end
end
