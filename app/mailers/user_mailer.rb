class UserMailer < ApplicationMailer
  def new_items(user_id)
    @user = User.find(user_id)

    @feed_items = @user.feeds.map do |feed|
      items = feed.new_items!
      feed.update_column(:publish_date_last_sent_item, items.first.publish_date) if items.any?
      items
    end.flatten.compact

    if @feed_items.any? && @user.wants_email?
      date = I18n.l(Time.zone.today.to_date)

      mail(
        to: @user.email,
        bcc: "rssmailer@jankeesvw.com",
        subject: "RSSMailer – #{@feed_items.count} new items on #{date}",
      )
    end
  end

  def test_email(to)
    @user = User.first
    @feed_items = SampleContent.items

    mail(
      to: to,
      subject: "RSSMailer test email - #{rand}",
      template_name: "new_items",
    )
  end
end
