class UserAgent
  def self.user_agent_for(url)
    if Rails.env.test? || url.start_with?("https://www.youtube.com/")
      "Ruby"
    else
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0) Gecko/20100101 Firefox/68.0"
    end
  end
end
