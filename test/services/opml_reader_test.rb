require "test_helper"

class OpmlReaderTest < ActiveSupport::TestCase
  test "gets feeds from an OPML document" do
    document = <<OPML
<?xml version="1.0" encoding="UTF-8"?>
<opml version="1.0">
    <body>
        <outline text="Apple">
            <outline text="MacRumors: Mac News and Rumors - All Stories" type="rss" xmlUrl="http://feeds.macrumors.com/MacRumors-All"></outline>
            <outline text="One More Thing" type="rss" xmlUrl="https://www.onemorething.nl/feed/"></outline>
        </outline>
    </body>
</opml>
OPML

    reader = OpmlReader.new(document)
    assert_equal(2, reader.feeds.count)
    assert_equal("MacRumors: Mac News and Rumors - All Stories", reader.feeds.first.name)
    assert_equal("http://feeds.macrumors.com/MacRumors-All", reader.feeds.first.feed_url)
    assert_equal("http://feeds.macrumors.com/MacRumors-All", reader.feeds.first.url)
  end
end
