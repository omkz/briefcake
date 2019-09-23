class PagesController < ApplicationController
  def stats
    render plain: "#{User.count},#{Feed.count},#{SentEmail.count}"
  end

  def example
    @user = current_user
    @feed_items = SampleContent.items
    @index = SampleContent.index unless params[:no_index].present?

    render "user_mailer/new_items", layout: "mailer"
  end

  def subscribe
  end

  def pro
  end
end
