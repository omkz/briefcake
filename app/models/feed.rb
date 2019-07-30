class Feed < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  validates :url, url: true
  validates :name, presence: true

  after_create :set_publish_date_last_sent_item!
  belongs_to :user

  def can_be_fetched?
    if is_instagram?
      true
    else
      rss_feed_url.present?
    end
  end

  def fetch_url
    if is_instagram?
      url
    else
      rss_feed_url
    end
  end

  def instagram_user_name
    if is_instagram?
      matches = /instagram.com\/(.+?)\//.match(url)
      if matches
        matches[1]
      end
    end
  end

  def is_instagram?
    url.present? && url.include?("instagram.com")
  end

  def new_items!
    return [] if publish_date_last_sent_item.nil?

    items!.filter { |item| item.publish_date > self.publish_date_last_sent_item }
  end

  def items!
    FeedReader.new(self).fetch_items!
  end

  private

  def set_publish_date_last_sent_item!
    update_column(:publish_date_last_sent_item, items!.first.publish_date)
  end
end
