class Down
  class NotFoundError < StandardError; end

  def initialize(feed)
    @feed = feed
  end

  def fetch
    response = HTTParty.get(
      feed,
      headers: { "User-Agent" => user_agent },
      open_timeout: 25,
      read_timeout: 25
    )

    case response.code
    when 404
      raise NotFoundError
    end

    response.body
  end

  private

  attr_reader :feed

  def user_agent
    if Rails.env.test? || feed.start_with?("https://www.youtube.com/")
      "Ruby"
    else
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0) Gecko/20100101 Firefox/68.0"
    end
  end
end