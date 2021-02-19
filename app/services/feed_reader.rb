class FeedReader
  include UrlHelpers

  def initialize(feed)
    @feed = feed
  end

  def fetch_items!
    exception_occurred = nil

    items = begin
              rss_feed_entries.map do |feed_jira_entry|
                FeedItem.new(
                  feed: feed,
                  title: feed_jira_entry.title.to_s.squish,
                  description: feed_jira_entry.summary.to_s.squish,
                  link: add_domain_to_url(feed_jira_entry.url, feed.feed_url),
                  publish_date: feed_jira_entry.published,
                  image_url: feed_jira_entry.try(:media_thumbnail_url)
                )
              end
            rescue => e
              exception_occurred = e.to_s
              []
            end

    feed.update_column(:fetch_error, exception_occurred) if feed.persisted?

    items = [] if items.nil?
    items.reject! { |item| item.publish_date.blank? }
    items.sort_by(&:publish_date).reverse
  end

  private

  def feed
    @feed
  end

  def rss_feed_entries
    xml = HTTParty.get(feed.feed_url, headers: { "User-Agent" => UserAgent.user_agent_for(feed.feed_url) }).body
    Feedjira.parse(xml).entries
  end
end
