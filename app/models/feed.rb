class Feed < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  validates :url, url: true
  validates :name, presence: true

  has_many :feed_items, dependent: :destroy
  belongs_to :user

  before_save :get_rss_feed!

  def is_instagram?
    url.include?("instagram.com")
  end

  def get_rss_feed!
    self[:rss_feed_url] = if is_instagram?
                            url
                          else
                            RssUrlFinder.new(url).find_for_url
                          end
  end
end
