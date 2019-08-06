class FeedReader
  def initialize(feed)
    @feed = feed
  end

  def fetch_items!
    exception_occurred = nil

    items = begin
      if feed.is_instagram?
        user = Instagrammer.new(feed.instagram_user_name)
        user.get_posts(3).map do |post|
          if post.photo?
            FeedItem.new(
              feed: feed,
              title: post.caption,
              link: "https://www.instagram.com/p/#{post.shortcode}/",
              publish_date: post.upload_date,
              image_url: post.image_url,
            )
          else
            nil
          end
        end.compact
      else
        rss_feed_entries.map do |feed_jira_entry|
          FeedItem.new(
            feed: feed,
            title: feed_jira_entry.title.to_s.squish,
            description: feed_jira_entry.summary.to_s.squish,
            link: feed_jira_entry.url,
            publish_date: feed_jira_entry.published,
            image_url: feed_jira_entry.try(:media_thumbnail_url)
          )
        end
      end
    rescue => e
      exception_occurred = e.to_s
      []
    end

    feed.update_column(:fetch_error, exception_occurred) if feed.persisted?

    items = [] if items.nil?
    items.sort_by(&:publish_date).reverse
  end

  private

  def feed
    @feed
  end

  def rss_feed_entries
    xml = HTTParty.get(feed.rss_feed_url).body
    Feedjira.parse(xml).entries
  end
end
