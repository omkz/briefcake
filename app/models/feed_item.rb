class FeedItem < ApplicationRecord
  belongs_to :feed
  has_one :user, through: :feed

  validates_uniqueness_of :link, scope: :feed_id
end
