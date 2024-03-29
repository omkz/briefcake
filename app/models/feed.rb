class Feed < ApplicationRecord
  validates :url, url: true
  validates :name, presence: true
  validates :feed_url, presence: true
  validates_uniqueness_of :feed_url, scope: :user_id

  after_create :populate_publish_date_last_sent_item!
  belongs_to :user
  belongs_to :subscribe_form, optional: true

  scope :with_errors, -> { where.not(fetch_error: nil) }
  scope :form_created, -> { where.not(subscribe_form_id: nil) }
  scope :account_created, -> { where(subscribe_form_id: nil) }

  default_scope { order(:name) }

  def can_be_fetched?
    feed_url.present?
  end

  def is_youtube?
    url.present? && URI(url).host.eql?("www.youtube.com")
  end

  def is_instagram?
    url.present? && URI(url).host.eql?("www.instagram.com")
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
