require "test_helper"

class PageInfoFinderTest < ActiveSupport::TestCase
  test "finds the RSS Feed for Timi" do
    VCR.use_cassette("page_info_finder/timi") do
      find_for_url = PageInfoFinder.new("https://timiapp.com/blog").fetch!

      assert_equal("https://timiapp.com/blog.rss", find_for_url.feed_url)
      assert_equal("Het Timi weblog", find_for_url.name)
    end
  end

  test "finds the RSS Feed for Daring Fireball" do
    VCR.use_cassette("page_info_finder/daringfireball") do
      find_for_url = PageInfoFinder.new("https://daringfireball.net/").fetch!

      assert_equal("https://daringfireball.net/feeds/main", find_for_url.feed_url)
      assert_equal("Daring Fireball", find_for_url.name)
    end
  end

  test "returns nil if nothing is found" do
    VCR.use_cassette("page_info_finder/example") do
      find_for_url = PageInfoFinder.new("https://example.com").fetch!

      assert_nil(find_for_url.feed_url)
    end
  end

  test "returns nil name if nothing is found" do
    VCR.use_cassette("page_info_finder/example") do
      find_for_url = PageInfoFinder.new("https://example.404").fetch!

      assert_nil(find_for_url.name)
    end
  end

  test "follows redirects" do
    VCR.use_cassette("page_info_finder/timi_with_redirect") do
      find_for_url = PageInfoFinder.new("https://www.timiapp.com/blog").fetch!
      refute(find_for_url.is_rss_feed?)

      assert_equal({
                                          feed_url: "https://timiapp.com/blog.rss",
                                          name: "Het Timi weblog",
                                        }, find_for_url.to_json)
    end
  end

  test "returns all data for a URL" do
    VCR.use_cassette("page_info_finder/ars_technica") do
      find_for_url = PageInfoFinder.new("http://feeds.arstechnica.com/arstechnica/index/").fetch!
      assert(find_for_url.is_rss_feed?)

      assert_equal({
                                          name: "Ars Technica",
                                          feed_url: "http://feeds.arstechnica.com/arstechnica/index/",
                                        }, find_for_url.to_json)
    end
  end

  test "returns all data for a RSS feed" do
    VCR.use_cassette("page_info_finder/daringfireball") do
      find_for_url = PageInfoFinder.new("https://daringfireball.net/").fetch!

      assert_equal({
                                          feed_url: "https://daringfireball.net/feeds/main",
                                          name: "Daring Fireball",
                                        }, find_for_url.to_json)
    end
  end

  test "strips whteste space" do
    VCR.use_cassette("page_info_finder/hackernews") do
      find_for_url = PageInfoFinder.new("https://news.ycombinator.com/").fetch!

      assert_equal({
                                          feed_url: "https://news.ycombinator.com/rss",
                                          name: "Hacker News",
                                        },find_for_url.to_json)
    end
  end

  test "can handle // as feed url" do
    VCR.use_cassette("page_info_finder/zachholman") do
      find_for_url = PageInfoFinder.new("https://zachholman.com").fetch!

      assert_equal({
                                          feed_url: "https://zachholman.com/atom.xml",
                                          name: "Zach Holman",
                                        }, find_for_url.to_json)
    end
  end


  test "uses feeder to access instagram feeds" do
    VCR.use_cassette("page_info_finder/instgram/5katkov") do
      url_info = PageInfoFinder.new('https://www.instagram.com/5katkov/').fetch!

      assert_equal({
        feed_url: "https://feeder.briefcake.com/picuki/profile/5katkov/",
        name: "S.K. (@5katkov) - Picuki"}, url_info.to_json)
    end
  end


  test "handles youtube channel through feeder" do
    VCR.use_cassette("page_info_finder/youtube/channel") do
      url_info = PageInfoFinder.new('https://www.youtube.com/channel/UCnO0dcSgfp18PDxH5oNVpKQ').fetch!

      assert_equal({
        name: 'DJ Carlo Atendido - YouTube',
        feed_url: "https://feeder.briefcake.com/youtube/channel/UCnO0dcSgfp18PDxH5oNVpKQ"
        }, url_info.to_json)
    end
  end


  test "handles youtube user through feeder" do
    VCR.use_cassette("page_info_finder/youtube/user") do
      url_info = PageInfoFinder.new('https://www.youtube.com/user/djcarloatendido/playlists').fetch!

      assert_equal({
        name: 'djcarloatendido - YouTube',
        feed_url: "https://feeder.briefcake.com/youtube/user/djcarloatendido"
        }, url_info.to_json)
    end
  end
end
