class Announcement < ApplicationRecord
  ANNOUNCEMENT_TYPES = %w{ new bugfix update }
  SITE_WIDE_OPTIONS = %w{ visitors users }
  belongs_to :user

  after_initialize :set_defaults

  validates :title, :body, :announcement_type, :published_at, presence: true
  validates :announcement_type, inclusion: { in: ANNOUNCEMENT_TYPES }
  validates :show_site_wide, inclusion: { in: SITE_WIDE_OPTIONS }, allow_blank: true

  private

  def set_defaults
    self.published_at ||= Time.zone.now
    self.announcement_type ||= ANNOUNCEMENT_TYPES.first
  end
end
