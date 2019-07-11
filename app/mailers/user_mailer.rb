class UserMailer < ApplicationMailer
  def new_items(user_id)
    @user = User.find(user_id)
    @feed_items = @user.feed_items.includes(:feed)
    @feed_items.update_all(sent_at: Time.zone.now)

    mail to: @user.email
  end
end
