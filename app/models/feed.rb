class Feed < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  validates :url, url: true
  validates :name, presence: true

  after_create :populate_publish_date_last_sent_item!
  belongs_to :user

  scope :with_errors, -> { where.not(fetch_error: nil) }

  default_scope { order(:name) }

  def can_be_fetched?
    feed_url.present?
  end

  def instagram_user_name
    if is_instagram?
      matches = /instagram.com\/(.+?)\//.match(url)
      if matches
        matches[1]
      end
    end
  end

  def is_youtube?
    feed_url.present? && feed_url.start_with?("https://www.youtube.com/")
  end

  def is_instagram?
    feed_url.present? && feed_url.start_with?("https://www.instagram.com/")
  end

  def new_items!
    return [] if publish_date_last_sent_item.nil?

    items!.filter { |item| item.publish_date > self.publish_date_last_sent_item }
  end

  def items!
    FeedReader.new(self).fetch_items!
  end

  def has_fetch_error?
    fetch_error.present?
  end

  private

  def populate_publish_date_last_sent_item!
    return if self[:publish_date_last_sent_item].present?

    newest_item = items!.first
    if newest_item.present?
      update_column(:publish_date_last_sent_item, newest_item.publish_date)
    else
      update_column(:publish_date_last_sent_item, Time.zone.now)
    end
  end
end
