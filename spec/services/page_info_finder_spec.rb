require "rails_helper"

describe PageInfoFinder do
  describe "#feed_url" do
    it "finds the RSS Feed for Timi" do
      VCR.use_cassette("page_info_finder/timi") do
        find_for_url = PageInfoFinder.new("https://timiapp.com/blog").fetch!

        expect(find_for_url.feed_url).to eq "https://timiapp.com/blog.rss"
      end
    end

    it "return the url if it's instagram" do
      VCR.use_cassette("page_info_finder/instagram_timo") do
        find_for_url = PageInfoFinder.new("https://www.instagram.com/zwartekoffie/").fetch!

        expect(find_for_url.feed_url).to eq "https://www.instagram.com/zwartekoffie/"
      end
    end

    it "finds the RSS Feed for Daring Fireball" do
      VCR.use_cassette("page_info_finder/daringfireball") do
        find_for_url = PageInfoFinder.new("https://daringfireball.net/").fetch!

        expect(find_for_url.feed_url).to eq "https://daringfireball.net/feeds/main"
      end
    end

    it "returns nil if nothing is found" do
      VCR.use_cassette("page_info_finder/example") do
        find_for_url = PageInfoFinder.new("https://example.com").fetch!

        expect(find_for_url.feed_url).to be_nil
      end
    end
  end

  describe "#name" do
    it "finds the RSS Feed for Timi" do
      VCR.use_cassette("page_info_finder/timi") do
        find_for_url = PageInfoFinder.new("https://timiapp.com/blog").fetch!

        expect(find_for_url.name).to eq "Het Timi weblog"
      end
    end

    it "finds the RSS Feed for Daring Fireball" do
      VCR.use_cassette("page_info_finder/daringfireball") do
        find_for_url = PageInfoFinder.new("https://daringfireball.net/").fetch!

        expect(find_for_url.name).to eq "Daring Fireball"
      end
    end

    it "returns nil if nothing is found" do
      VCR.use_cassette("page_info_finder/example") do
        find_for_url = PageInfoFinder.new("https://example.404").fetch!

        expect(find_for_url.name).to be_nil
      end
    end
  end

  describe "#to_json" do
    it "follows redirects" do
      VCR.use_cassette("page_info_finder/timi_with_redirect") do
        find_for_url = PageInfoFinder.new("https://www.timiapp.com/blog").fetch!
        expect(find_for_url.is_rss_feed?).to be_falsey

        expect(find_for_url.to_json).to eq(
                                          {
                                            feed_url: "https://timiapp.com/blog.rss",
                                            name: "Het Timi weblog",
                                          }
                                        )
      end
    end

    it "returns all data for a URL" do
      VCR.use_cassette("page_info_finder/ars_technica") do
        find_for_url = PageInfoFinder.new("http://feeds.arstechnica.com/arstechnica/index/").fetch!
        expect(find_for_url.is_rss_feed?).to be_truthy

        expect(find_for_url.to_json).to eq(
                                          {
                                            name: "Ars Technica",
                                            feed_url: "http://feeds.arstechnica.com/arstechnica/index/",
                                          }
                                        )
      end
    end

    it "returns all data for a RSS feed" do
      VCR.use_cassette("page_info_finder/daringfireball") do
        find_for_url = PageInfoFinder.new("https://daringfireball.net/").fetch!

        expect(find_for_url.to_json).to eq(
                                          {
                                            feed_url: "https://daringfireball.net/feeds/main",
                                            name: "Daring Fireball",
                                          }
                                        )
      end
    end

    it "strips white space" do
      VCR.use_cassette("page_info_finder/hackernews") do
        find_for_url = PageInfoFinder.new("https://news.ycombinator.com/").fetch!

        expect(find_for_url.to_json).to eq(
                                          {
                                            feed_url: "https://news.ycombinator.com/rss",
                                            name: "Hacker News",
                                          }
                                        )
      end
    end

    it "can handle // as feed url" do
      VCR.use_cassette("page_info_finder/zachholman") do
        find_for_url = PageInfoFinder.new("https://zachholman.com").fetch!

        expect(find_for_url.to_json).to eq(
                                          {
                                            feed_url: "https://zachholman.com/atom.xml",
                                            name: "Zach Holman",
                                          }
                                        )
      end
    end
  end
end
