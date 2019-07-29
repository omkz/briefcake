require "rails_helper"

describe FeedReader do
  describe "#fetch_items!" do
    it "gets hacker news feed items" do
      feed = Feed.new(rss_feed_url: "https://news.ycombinator.com/rss")
      reader = FeedReader.new(feed)

      items = reader.fetch_items!
      expect(items).to have_at_least(1).item
    end
  end
end
