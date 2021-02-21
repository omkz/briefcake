require "nokogiri"
require "net/http"

class PageInfoFinder
  include UrlHelpers

  def initialize(url)
    @url = url
  end

  def fetch!
    @request = HTTParty::Request.new(Net::HTTP::Get, @url, headers: { "User-Agent" => UserAgent.user_agent_for(@url) })
    @performed_request = @request.perform
    @document = Nokogiri::HTML(@performed_request)
    @uri = @request.last_uri
    self
  rescue => e
    Honeybadger.notify(e)
    self
  end

  def is_rss_feed?
    @feed = Feedjira.parse(@performed_request.body)
    true
  rescue
    false
  end

  def feed_url
    return @url if is_rss_feed?

    feed_url = @document.css("link[rel=alternate][type*=xml]")[0]["href"]

    add_domain_to_url(feed_url, @uri)
  rescue
    nil
  end

  def name
    return @feed.title if is_rss_feed?
    @document.css("title")[0].text.to_s.squish
  rescue
    nil
  end

  def to_json
    { name: name, feed_url: feed_url }
  end
end
