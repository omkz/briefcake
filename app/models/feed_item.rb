class FeedItem < ApplicationRecord
  belongs_to :feed
  has_one :user, through: :feed

  validates_uniqueness_of :link, scope: :feed_id

  def self.unseen_items
    joins(:feed).where("publish_date > feeds.created_at").where(sent_at: nil)
  end
end
