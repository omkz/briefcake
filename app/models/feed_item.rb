class FeedItem < ApplicationRecord
  belongs_to :feed
  has_one :user, through: :feed

  validates_presence_of :publish_date
  validates_uniqueness_of :link, scope: :feed_id

  before_validation :add_publish_date

  def link
    if self[:link].blank?
      feed.url
    else
      self[:link]
    end
  end

  def self.unseen_items
    joins(:feed).where("publish_date > feeds.created_at").where(sent_at: nil)
  end

  def add_publish_date
    self[:publish_date] = Time.zone.now if publish_date.blank?
  end
end
