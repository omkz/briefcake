require "rails_helper"

describe PageInfoFinder do
  describe "#rss_feed_url" do
    it "finds the RSS Feed for Timi" do
      find_for_url = PageInfoFinder.new("https://timiapp.com/blog").fetch!

      expect(find_for_url.rss_feed_url).to eq "https://timiapp.com/blog.rss"
    end

    it "finds the RSS Feed for Daring Fireball" do
      find_for_url = PageInfoFinder.new("https://daringfireball.net/").fetch!

      expect(find_for_url.rss_feed_url).to eq "https://daringfireball.net/feeds/main"
    end

    it "returns nil if nothing is found" do
      find_for_url = PageInfoFinder.new("https://example.com").fetch!

      expect(find_for_url.rss_feed_url).to be_nil
    end
  end

  describe "#name" do
    it "finds the RSS Feed for Timi" do
      find_for_url = PageInfoFinder.new("https://timiapp.com/blog").fetch!

      expect(find_for_url.name).to eq "Het Timi weblog"
    end

    it "finds the RSS Feed for Daring Fireball" do
      find_for_url = PageInfoFinder.new("https://daringfireball.net/").fetch!

      expect(find_for_url.name).to eq "Daring Fireball"
    end

    it "returns nil if nothing is found" do
      find_for_url = PageInfoFinder.new("https://example.404").fetch!

      expect(find_for_url.name).to be_nil
    end
  end

  describe "#to_json" do
    it "returns all data for a URL" do
      find_for_url = PageInfoFinder.new("https://daringfireball.net/").fetch!

      expect(find_for_url.to_json).to eq(
        {
          rss_feed_url: "https://daringfireball.net/feeds/main",
          name: "Daring Fireball",
        }
      )
    end
  end
end
