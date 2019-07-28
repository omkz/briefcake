class FetchFeedItemsJob < ApplicationJob
  queue_as :default

  def perform(feed_id)
    @feed_id = feed_id

    feed_reader = FeedReader.new(feed)
    feed_items = feed_reader.fetch_items!
    feed_items.map(&:save)
  end

  private

  def feed
    @feed ||= Feed.find(@feed_id)
  end

end
