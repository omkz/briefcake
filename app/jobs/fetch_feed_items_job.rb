class FetchFeedItemsJob < ApplicationJob
  queue_as :default

  def perform(feed_id)
    @feed_id = feed_id

    entries.each do |feed_jira_entry|
      feed.feed_items.create(
        title: feed_jira_entry.title,
        description: feed_jira_entry.summary,
        link: feed_jira_entry.url,
        publish_date: feed_jira_entry.published
      )
    end
  end

  def feed
    Feed.find(@feed_id)
  end

  def entries
    xml = HTTParty.get(feed.url).body
    Feedjira.parse(xml).entries
  end
end
