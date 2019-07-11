class UserMailer < ApplicationMailer
  def new_items(user_id)
    @user = User.find(user_id)
    @feed_items = @user.feed_items.unseen_items.includes(:feed)
    if @feed_items.any?
      date = I18n.l(Time.zone.today.to_date)
      mail(to: @user.email, subject: "RSSMailer – #{@feed_items.count} new items – #{date}")
      @feed_items.update_all(sent_at: Time.zone.now)
    end
  end
end
