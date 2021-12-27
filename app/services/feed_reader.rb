class FeedReader
  include UrlHelpers

  def initialize(feed)
    @feed = feed
  end

  def fetch_items!
    exception_occurred = nil

    items = begin
      feed_data = rss_feed

      if feed.is_instagram?
        ServiceMessage.create(service_type: "instagram",
          data: feed_data
        )
      end

      feed_data.entries.map do |feed_jira_entry|
        FeedItem.new(
          feed: feed,
          title: feed_jira_entry.title.to_s.squish,
          description: feed_jira_entry.summary.to_s.squish,
          link: add_domain_to_url(feed_jira_entry.url, feed.feed_url),
          publish_date: feed_jira_entry.published,
          image_url: feed_jira_entry.try(:media_thumbnail_url)
        )
      end
    rescue SocketError, Errno::ECONNREFUSED, Errno::ECONNRESET => e
      # this is probably results of Heroku being banned in China. We can't retrieve data from chinese servers (they ban through DNS)

      exception_occurred = e.to_s
      []

    rescue Net::OpenTimeout => e
      exception_occurred = e.to_s
      []

    rescue => e
      # FIXME: this needs a better error handling
      # - Net::ReadTimeout, Net::OpenTimeout -- can try to retry
      # - URI::InvalidURIError, HTTParty::UnsupportedURIScheme
      # - HTTParty::RedirectionTooDeep
      # - Rack::Timeout::RequestTimeoutException

      Honeybadger.notify(e, context: {
        feed: feed
      })

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

  def rss_feed
    Feedjira.parse(Down.new(feed.feed_url).fetch)
  end
end
