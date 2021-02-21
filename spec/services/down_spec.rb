require "rails_helper"

describe "Down" do
  it 'fetched a feed that requires a redirect' do
    VCR.use_cassette("devblog feed") do
      xml = Down.new("http://devblog.avdi.org/feed/").fetch

      assert_equal "avdi.codes", Feedjira.parse(xml).title
    end
  end

  it 'fetches a normal feed' do
    VCR.use_cassette("derrick feed") do
      xml = Down.new("https://www.derrickreimer.com/feed.xml").fetch

      assert_equal "derrickreimer.com", Feedjira.parse(xml).title
    end
  end
end