require "rails_helper"

describe Feed do
  describe "#instagram_user_name" do
    it "gets the user_name" do
      feed = Feed.new(feed_url: "https://www.instagram.com/zwartekoffie/")
      expect(feed.instagram_user_name).to eq "zwartekoffie"
    end

    it "returns nil for invalid urls" do
      feed = Feed.new(feed_url: "https://www.instagram.com")
      expect(feed.instagram_user_name).to be_nil

      feed = Feed.new(feed_url: "https://www.instagram.commm/123")
      expect(feed.instagram_user_name).to be_nil
    end
  end
end
