class FetchFeedItemsJob < ApplicationJob
  queue_as :default

  def perform(feed_id)
    @feed_id = feed_id

    if feed.is_instagram?
      begin
        user = Instagrammer.new(feed.instagram_user_name)
        user.get_posts(5).each do |post|
          begin
            if post.photo?
              feed.feed_items.create(
                title: post.caption,
                link: "https://www.instagram.com/p/#{post.shortcode}/",
                publish_date: post.upload_date,
                image_url: post.image_url,
              )
            else
              Rails.logger.warn "Import failed, not a photo (feed: #{feed_id}}"
            end
          rescue => e
            Rails.logger.error "Exception: #{e} (feed: #{feed_id}}"
            Rollbar.error(e)
          end
        end
      rescue => e
        Rails.logger.error "Cannot fetch: #{feed.instagram_user_name}: #{e}"
        Rollbar.error(e)
      end
    else
      entries.each do |feed_jira_entry|
        feed.feed_items.create(
          title: feed_jira_entry.title,
          description: feed_jira_entry.summary,
          link: feed_jira_entry.url,
          publish_date: feed_jira_entry.published,
        )
      end
    end
  end

  private

  def feed
    @feed ||= Feed.find(@feed_id)
  end

  def entries
    xml = HTTParty.get(feed.rss_feed_url).body
    Feedjira.parse(xml).entries
  end
end
