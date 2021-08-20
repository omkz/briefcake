require "nokogiri"
require "net/http"

class PageInfoFinder
  include UrlHelpers

  FEEDER_URL = 'https://feeder.briefcake.com'

  def initialize(url)
    uri = URI(url)
    @url = case(uri.host)
           when "www.instagram.com"
             instagram_feed(uri.path[1..])
           when "www.youtube.com"
             youtube_feed(uri)
           else
             url
           end

  end

  def fetch!
    @request = HTTParty::Request.new(Net::HTTP::Get, @url, headers: { "User-Agent" => UserAgent.user_agent_for(@url) })
    @performed_request = @request.perform
    @document = Nokogiri::HTML(@performed_request.body)
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

  private

  def instagram_feed(username)
    "#{FEEDER_URL}/picuki/profile/#{username}"
  end

  def youtube_feed(uri)
    case uri.path.split("/")[1]
    when 'user'
      "#{FEEDER_URL}/youtube/user/#{uri.path.split("/")[2]}"
    when 'channel'
      "#{FEEDER_URL}/youtube/channel/#{uri.path.split("/")[2]}"
    end
  end

  def youtube?
    URI(@url).host.ends_with?('youtube.com')
  end

  def instagram?
    URI(@url).host.eql?("www.instagram.com")
  end
end
