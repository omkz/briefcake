require "test_helper"

class FeedReaderTest < ActiveSupport::TestCase
  test "gets youtube video previews for a YouTube XML" do
    VCR.use_cassette("feed_reader/youtube") do
      feed = Feed.new(feed_url: "https://www.youtube.com/feeds/videos.xml?channel_id=UCCVxhT-bl0ZMRzbpNolErCg")
      reader = FeedReader.new(feed)

      items = reader.fetch_items!

      assert_equal(12, items.count)

      first_item = items.first
      assert_equal("Asturias", first_item.title)
      assert_equal("", first_item.description)
      assert_equal(Time.utc(2018, 8, 11, 4, 11, 44), first_item.publish_date)
      assert_equal("https://i4.ytimg.com/vi/768WjoD62wU/hqdefault.jpg", first_item.image_url)
    end
  end

  test "saves an error when the feed cannot be read, reset when it's okay again" do
    feed = create(:feed, feed_url: "https://example.com")

    VCR.use_cassette("feed_reader/example") do
      reader = FeedReader.new(feed)

      items = reader.fetch_items!

      assert_equal(0, items.count)
      assert_equal("No valid parser for XML.", feed.reload.fetch_error)
    end

    VCR.use_cassette("feed_reader/hacker-news") do
      feed.update(feed_url: "https://news.ycombinator.com/rss")
      reader = FeedReader.new(feed)

      items = reader.fetch_items!

      assert_equal(30, items.count)
      assert_nil(feed.reload.fetch_error)
    end
  end

  test "doesn't trip over a feed with one post without a publish_date" do
    VCR.use_cassette("feed_reader/hacker-news-without-publish-date") do
      feed = Feed.new(feed_url: "https://news.ycombinator.com/rss")
      reader = FeedReader.new(feed)

      items = reader.fetch_items!

      first_item = items.first
      assert_equal("You’re Paying into a Broken System Whenever You Buy Something on iOS", first_item.title)
      assert_equal("<a href=\"https://news.ycombinator.com/item?id=20565192\">Comments</a>", first_item.description)
      assert_equal(Time.utc(2019, 7, 30, 14, 39, 14), first_item.publish_date)

      last_item = items.last
      assert_equal("How to Bypass “Slider Captcha”", last_item.title)
      assert_equal("<a href=\"https://news.ycombinator.com/item?id=20542350\">Comments</a>", last_item.description)
      assert_equal(Time.utc(2019, 7, 27, 15, 9, 16), last_item.publish_date)
    end
  end

  test "adds the URL if it's a path" do
    VCR.use_cassette("feed_reader/reinierladan") do
      feed = Feed.new(feed_url: "https://reinierladan.nl/feed/index.xml")
      reader = FeedReader.new(feed)

      items = reader.fetch_items!

      first_item = items.first
      assert_equal( "Clueyness Anxiety Tobolowsky", first_item.title)
      assert_equal("Hi, Reinier hier,", first_item.description)
      assert_equal(Time.utc(2019, 9, 26, 6, 20, 0), first_item.publish_date)
      assert_equal("https://reinierladan.nl/2019/09/26/Clueyness-Anxiety-Tobolowsky", first_item.link)
    end
  end

  test "gets hacker news feed items" do
    VCR.use_cassette("feed_reader/hacker-news") do
      feed = Feed.new(feed_url: "https://news.ycombinator.com/rss")
      reader = FeedReader.new(feed)

      items = reader.fetch_items!

      first_item = items.first
      assert_equal("You’re Paying into a Broken System Whenever You Buy Something on iOS", first_item.title)
      assert_equal("<a href=\"https://news.ycombinator.com/item?id=20565192\">Comments</a>", first_item.description)
      assert_equal(Time.utc(2019, 7, 30, 14, 39, 14), first_item.publish_date)

      last_item = items.last
      assert_equal( "How to Bypass “Slider Captcha”", last_item.title)
      assert_equal("<a href=\"https://news.ycombinator.com/item?id=20542350\">Comments</a>", last_item.description)
      assert_equal(Time.utc(2019, 7, 27, 15, 9, 16), last_item.publish_date)
    end
  end
end
