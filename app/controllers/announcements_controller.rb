  class AnnouncementsController < ApplicationController
  before_action :mark_all_as_read, if: :user_signed_in?

  def index
    @announcements = Announcement.order(published_at: :desc)
  end

  private

  def mark_all_as_read
    current_user.update!(last_announcement_read_at: Time.current)
  end
end

