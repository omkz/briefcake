class UserMailerPreview < ActionMailer::Preview
  def newsletter_pro
    mail = UserMailer.with(
      user: User.first,
      feed_items: SampleContent.items,
      index: SampleContent.index
    ).newsletter

    Premailer::Rails::Hook.perform(mail)
  end

  def newsletter
    mail = UserMailer.with(
      user: User.second,
      feed_items: SampleContent.items,
      index: SampleContent.index
    ).newsletter

    Premailer::Rails::Hook.perform(mail)
  end
end
