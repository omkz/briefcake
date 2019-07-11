module AnnouncementsHelper
  def unread_announcements_class(user)
    return if last_announcement.nil?

    "nav__item-announcements--unread" if has_unread_announcements?(user)
  end

  def show_site_wide_announcement(user)
    return if last_announcement.nil?
    return if !last_announcement.show_site_wide?
    return if !has_unread_announcements?(user)
    return if has_dismissed_announcement?

    if (user_signed_in? and last_announcement.show_site_wide == "users") or
       last_announcement.show_site_wide == "visitors"
      render "shared/site_announcement"
    end
  end

  private

  def last_announcement
    Announcement.order(published_at: :desc).first
  end

  def has_unread_announcements?(user)
    if user.nil? ||
       user.last_announcement_read_at.nil? ||
       user.last_announcement_read_at < last_announcement.published_at
      true
    end
  end

  def has_dismissed_announcement?
    cookies["_#{Rails.configuration.application_name.parameterize}_announcement_#{last_announcement.id}"]
  end
end
