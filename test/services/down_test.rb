require "test_helper"

class DownTest < ActiveSupport::TestCase
	test 'fetched a feed that requires a redirect' do
    VCR.use_cassette("devblog feed") do
      xml = Down.new("http://devblog.avdi.org/feed/").fetch

      assert_equal "avdi.codes", Feedjira.parse(xml).title
    end
  end

  test 'fetches a normal feed' do
    VCR.use_cassette("derrick feed") do
      xml = Down.new("https://www.derrickreimer.com/feed.xml").fetch

      assert_equal "derrickreimer.com", Feedjira.parse(xml).title
    end
  end


  test "should handle 404 error" do
    VCR.use_cassette('404 page') do
      assert_raises(Down::NotFoundError) { Down.new('http://lightrains.org/rss').fetch }
    end
  end
end
