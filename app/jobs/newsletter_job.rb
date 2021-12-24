class NewsletterJob < ApplicationJob
  queue_as :low

  def perform(user_id, dry_run: false)
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
      unless dry_run
        UserMailer.with(user: @user,
                        feed_items: @feed_items,
                        index: @index).newsletter.deliver_now
      end
    end
  end
end