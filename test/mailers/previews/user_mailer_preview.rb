class UserMailerPreview < ActionMailer::Preview
  def newsletter_pro
    UserMailer.with(
      user: User.first,
      feed_items: SampleContent.items,
      index: SampleContent.index
    ).newsletter
  end

  def newsletter
    UserMailer.with(
      user: User.second,
      feed_items: SampleContent.items,
      index: SampleContent.index
    ).newsletter
  end
end
