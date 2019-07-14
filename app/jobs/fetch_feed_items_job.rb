class FetchFeedItemsJob < ApplicationJob
  queue_as :default

  def perform(feed_id)
    @feed_id = feed_id

    if feed.is_instagram?
      user = Instagrammer.new(instagram_user_name)
      begin
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
          end
        end
      rescue => e
        Rails.logger.error "Cannot fetch: #{instagram_user_name}: #{e}"
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

  def instagram_user_name
    if is_instagram?
      matches = /instagram.com\/(.+?)\//.match(feed.url)
      if matches
        user_name = matches[1]
      else
        raise "No user name found in: #{feed.url}"
      end
    end
  end

  def feed
    @feed ||= Feed.find(@feed_id)
  end

  def entries
    xml = HTTParty.get(feed.url).body
    Feedjira.parse(xml).entries
  end
end
