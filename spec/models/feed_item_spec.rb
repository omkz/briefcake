require "rails_helper"

describe FeedItem do
  describe "#link" do
    it "always has a link" do
      feed = build(:feed, created_at: 1.month.ago, url: "https://feedslink.com")
      without_link = build(:feed_item, link: nil, feed: feed)
      with_link = build(:feed_item, link: "https://itemslink.com", feed: feed)

      expect(with_link.link).to eq "https://itemslink.com"
      expect(without_link.link).to eq "https://feedslink.com"
    end
  end
end
