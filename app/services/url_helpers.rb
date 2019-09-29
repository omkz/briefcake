module UrlHelpers
  def add_domain_to_url(feed_url, domain)
    puts "hai"
    domain = URI(domain) if domain.is_a?(String)

    if /^https?:/.match(feed_url)
      feed_url.to_s.squish
    elsif /^\/\//.match(feed_url)
      domain.scheme + ":" + feed_url
    else
      feed_url = feed_url.to_s.squish
      feed_url = "/" + feed_url unless feed_url.start_with?("/")

      domain.scheme + "://" + domain.host + feed_url
    end
  rescue
    feed_url
  end
end
