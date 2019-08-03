class UserMailer < ApplicationMailer
  def new_items(user_id)
    @user = User.find(user_id)

    @index = {}
    @feed_items = @user.feeds.map do |feed|
      items = feed.new_items!
      if items.any?
        feed.update_column(:publish_date_last_sent_item, items.first.publish_date)
        @index[feed.name] = items.count
      end
      items
    end.flatten.compact

    if @feed_items.any? && @user.wants_email?
      date = I18n.l(Time.zone.today.to_date)

      subject = "RSSMailer – #{@feed_items.count} new items on #{date}"

      mail(
        to: @user.email,
        subject: subject,
      )

      SentEmail.create(
        receiver: @user.email,
        user: @user,
        subject: subject,
        number_of_items: @feed_items.count,
        index: @index
      )
    end
  end

  def test_email(to)
    @user = User.first
    @feed_items = SampleContent.items
    @index = SampleContent.index

    mail(
      to: to,
      subject: "RSSMailer test email - #{rand}",
      template_name: "new_items",
    )
  end
end
