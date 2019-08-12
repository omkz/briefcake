class OpmlReader
  def initialize(string)
    @string = string
  end

  def feeds
    html = Nokogiri::HTML(@string)
    html.css("outline[type=rss]").map do |node|
      Feed.new({ name: node["text"], feed_url: node["xmlurl"], url: node["xmlurl"] })
    end
  end
end
