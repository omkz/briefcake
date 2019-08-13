require "rails_helper"

describe OpmlReader do
  describe "#feeds" do
    it "gets feeds from an OPML document" do
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
      expect(reader.feeds).to have(2).items
      expect(reader.feeds.first.name).to eq "MacRumors: Mac News and Rumors - All Stories"
      expect(reader.feeds.first.feed_url).to eq "http://feeds.macrumors.com/MacRumors-All"
      expect(reader.feeds.first.url).to eq "http://feeds.macrumors.com/MacRumors-All"
    end
  end
end
