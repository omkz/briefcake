class FeedReader
  def initialize(feed)
    @feed = feed
  end

  def fetch_items!
    begin
      if feed.is_instagram?
        user = Instagrammer.new(feed.instagram_user_name)
        user.get_posts(5).map do |post|
          if post.photo?
            @feed.feed_items.new(
              title: post.caption + "x",
              link: "https://www.instagram.com/p/#{post.shortcode}/",
              publish_date: post.upload_date,
              image_url: post.image_url,
            )
          else
            Rollbar.error("Import failed, not a photo (feed: #{feed.url}}")
            Rails.logger.warn "Import failed, not a photo (feed: #{feed.url}}"
            nil
          end
        end.compact
      else
        rss_feed_entries.map do |feed_jira_entry|
          feed.feed_items.new(
            title: feed_jira_entry.title,
            description: feed_jira_entry.summary,
            link: feed_jira_entry.url,
            publish_date: feed_jira_entry.published,
          )
        end
      end
    rescue => e
      Rails.logger.error "Cannot fetch: #{feed.id}: #{e}"
      Rollbar.error(e)
      []
    end
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
