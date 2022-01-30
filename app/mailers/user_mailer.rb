class UserMailer < ApplicationMailer
  def newsletter
    @user = params[:user]
    @feed_items = params[:feed_items]
    @index = params[:index]
    subject = t("user_mailer.subject", count: @feed_items.count, date: I18n.l(Time.zone.today.to_date))

    mail(
      to: @user.email,
      subject: subject
    )

    MIXPANEL.track(@user.id, 'newsletter sent', {
      'feed_count' => @feed_items.count,
      'feeds' => @feed_items
    })

    SentEmail.create(
      receiver: @user.email,
      user: @user,
      subject: subject,
      number_of_items: @feed_items.count,
      index: @index
    )
  end

  def test_email(to)
    @user = User.first
    @feed_items = SampleContent.items
    @index = SampleContent.index

    mail(
      to: to,
      bcc: "contact@briefcake.com",
      subject: "briefcake test email - #{rand}"
    )
  end
end
