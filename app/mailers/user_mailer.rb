class UserMailer < ApplicationMailer
  def new_items(user_id, dry_run: false)
    start_time = Time.now

    @user = User.find(user_id)

    return if @user.sent_emails.order(created_at: :desc).first&.created_at&.today?

    @index = {}
    @feed_items = @user.feeds.map do |feed|
      items = feed.new_items!
      if items.any?
        feed.update_column(:publish_date_last_sent_item, items.first.publish_date) unless dry_run
        @index[feed.name] = items.count
      end
      items
    end.flatten.compact

    if @feed_items.any? && @user.wants_email?
      date = I18n.l(Time.zone.today.to_date)

      subject = t("user_mailer.subject", count: @feed_items.count, date: date)

      mail(
        to: @user.email,
        subject: subject,
      )

      SentEmail.create(
        receiver: @user.email,
        user: @user,
        subject: subject,
        number_of_items: @feed_items.count,
        index: @index,
        compose_duration_in_seconds: (Time.now - start_time)
      ) unless dry_run
    end
  end

  def new_payment(user, data, verified)
    @user = user
    @data = {}
    @verified = verified

    data.each do |key_value|
      @data[key_value[0]] = key_value[1] unless key_value[0] === "paddle"
    end

    mail(
      to: "rssmailer@piplabs.io",
      subject: "New payment",
    )
  end

  def test_email(to)
    @user = User.first
    @feed_items = SampleContent.items
    @index = SampleContent.index

    mail(
      to: to,
      bcc: "rssmailer@piplabs.io",
      subject: "RSSMailer test email - #{rand}",
      template_name: "new_items",
    )
  end
end
