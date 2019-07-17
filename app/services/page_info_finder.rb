class PageInfoFinder
  include Capybara::DSL

  def initialize(url)
    @url = url
  end

  def fetch!
    visit @url
    self
  rescue => e
    self
  end

  def rss_feed_url
    page.first("link[rel=alternate][type*=xml]", visible: :all)[:href]
  rescue
    nil
  end

  def name
    page.first("title", visible: :all)['innerHTML']
  rescue
    nil
  end

  def to_json
    {name: name, rss_feed_url: rss_feed_url}
  end
end
