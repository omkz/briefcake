class FeedItem < ApplicationRecord
  belongs_to :feed

  validates_uniqueness_of :link, scope: :feed_id
end
