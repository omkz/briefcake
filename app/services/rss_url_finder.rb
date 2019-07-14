class RssUrlFinder
  include Capybara::DSL

  def initialize(url)
    @url = url
  end

  def find_for_url
    visit @url
    page.first("link[rel=alternate][type*=xml]", visible: :all)[:href]
  rescue => e
    nil
  end
end
