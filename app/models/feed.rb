class Feed < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  validates :url, url: true
  validates :name, presence: true

  after_create :populate_publish_date_last_sent_item!
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
    url.present? && url.start_with?("https://www.instagram.com/")
  end

  def new_items!
    return [] if publish_date_last_sent_item.nil?

    items!.filter { |item| item.publish_date > self.publish_date_last_sent_item }
  end

  def items!
    items = FeedReader.new(self).fetch_items!

    if items.none?
      exception = "No valid items found in feed: #{url} - #{id}"
      Rails.logger.info exception
      Rollbar.info exception
    end

    items
  end

  private

  def populate_publish_date_last_sent_item!
    newest_item = items!.first
    if newest_item.present?
      update_column(:publish_date_last_sent_item, newest_item.publish_date)
    else
      update_column(:publish_date_last_sent_item, Time.zone.now)
    end
  end
end
