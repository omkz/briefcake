require "nokogiri"
require "net/http"

class PageInfoFinder
  def initialize(url)
    @url = url
  end

  def fetch!
    @request = HTTParty::Request.new(Net::HTTP::Get, @url)
    @document = Nokogiri::HTML(@request.perform)
    @uri = @request.last_uri
    self
  rescue => e
    self
  end

  def rss_feed_url
    feed_url = @document.css("link[rel=alternate][type*=xml]")[0]["href"]

    if /^https?:/.match(feed_url)
      feed_url.to_s.squish
    else
      feed_url = feed_url.to_s.squish
      feed_url = "/" + feed_url unless feed_url.start_with?("/")

      @uri.scheme + "://" + @uri.host + feed_url
    end
  rescue
    nil
  end

  def name
    @document.css("title")[0].text.to_s.squish
  rescue
    nil
  end

  def to_json
    { name: name, rss_feed_url: rss_feed_url }
  end
end
