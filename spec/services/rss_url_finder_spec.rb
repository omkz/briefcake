require "rails_helper"

describe RssUrlFinder do
  describe "#find_for_url" do
    it "finds the RSS Feed for Timi" do
      find_for_url = RssUrlFinder.new("https://timiapp.com/blog").find_for_url

      expect(find_for_url).to eq "https://timiapp.com/blog.rss"
    end

    it "finds the RSS Feed for Daring Fireball" do
      find_for_url = RssUrlFinder.new("https://daringfireball.net/").find_for_url

      expect(find_for_url).to eq "https://daringfireball.net/feeds/main"
    end

    it "returns nil if nothing is found" do
      find_for_url = RssUrlFinder.new("https://example.com").find_for_url

      expect(find_for_url).to be_nil
    end
  end
end
