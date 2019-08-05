require "rails_helper"

describe FeedReader do
  describe "#fetch_items!" do
    it "gets youtube video previews for a YouTube XML" do
      VCR.use_cassette("feed_reader/youtube") do
        feed = Feed.new(rss_feed_url: "https://www.youtube.com/feeds/videos.xml?channel_id=UCCVxhT-bl0ZMRzbpNolErCg")
        reader = FeedReader.new(feed)

        items = reader.fetch_items!
        expect(items).to have(12).items

        first_item = items.first
        expect(first_item.title).to eq "Asturias"
        expect(first_item.description).to eq ""
        expect(first_item.publish_date).to eq Time.utc(2018, 8, 11, 4, 11, 44)
        expect(first_item.image_url).to eq "https://i4.ytimg.com/vi/768WjoD62wU/hqdefault.jpg"
      end
    end

    it "gets hacker news feed items" do
      VCR.use_cassette("feed_reader/hacker-news") do
        feed = Feed.new(rss_feed_url: "https://news.ycombinator.com/rss")
        reader = FeedReader.new(feed)

        items = reader.fetch_items!
        expect(items).to have(30).items

        first_item = items.first
        expect(first_item.title).to eq "You’re Paying into a Broken System Whenever You Buy Something on iOS"
        expect(first_item.description).to eq "<a href=\"https://news.ycombinator.com/item?id=20565192\">Comments</a>"
        expect(first_item.publish_date).to eq Time.utc(2019, 7, 30, 14, 39, 14)

        last_item = items.last
        expect(last_item.title).to eq  "How to Bypass “Slider Captcha”"
        expect(last_item.description).to eq "<a href=\"https://news.ycombinator.com/item?id=20542350\">Comments</a>"
        expect(last_item.publish_date).to eq Time.utc(2019, 7, 27, 15, 9, 16)
      end
    end
  end
end
