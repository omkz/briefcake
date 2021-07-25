require "test_helper"

class DummyClass
  include UrlHelpers
end

class FeedReaderTest < ActiveSupport::TestCase
  def subject
    DummyClass.new
  end

  test "makes a valid full URL" do
    assert_equal("http://rssmailer.app/test", subject.add_domain_to_url("/test", "http://rssmailer.app"))
    assert_equal("http://rssmailer.app/test4", subject.add_domain_to_url("http://rssmailer.app/test4", "http://rssmailer.app"))
    assert_equal("http://rssmailer.app/test4", subject.add_domain_to_url("test4", "http://rssmailer.app"))
    assert_equal("https://rssmailer.app/test4", subject.add_domain_to_url("test4", "https://rssmailer.app"))
  end

  test "can handle URI as input" do
    assert_equal("https://rssmailer.app/test4", subject.add_domain_to_url("test4", URI("https://rssmailer.app")))
  end

  test "ignores the path on the domain part" do
    assert_equal("https://rssmailer.app/test4", subject.add_domain_to_url("test4", URI("https://rssmailer.app/feed/rss.xml")))
  end

  test "handles nil cases" do
    assert_equal("/", subject.add_domain_to_url(nil, nil))
    assert_equal("http://rssmailer.app/", subject.add_domain_to_url(nil, "http://rssmailer.app"))
    assert_equal("/test4", subject.add_domain_to_url("/test4", nil))
  end
end
