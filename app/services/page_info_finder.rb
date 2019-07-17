require "nokogiri"
require "net/http"

# get the HTML from the website

class PageInfoFinder
  def initialize(url)
    @url = url
  end

  def fetch!
    @uri = URI(@url)
    @document = Nokogiri::HTML(Net::HTTP.get(@uri))
    self
  rescue => e
    self
  end

  def rss_feed_url
    feed_url = @document.css("link[rel=alternate][type*=xml]")[0]["href"]

    if /^https?:/.match(feed_url)
      feed_url
    else
      @uri.scheme + "://" + @uri.host + feed_url
    end
  rescue
    nil
  end

  def name
    @document.css("title")[0].text
  rescue
    nil
  end

  def to_json
    { name: name, rss_feed_url: rss_feed_url }
  end
end
