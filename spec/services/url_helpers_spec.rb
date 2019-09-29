require "rails_helper"

describe UrlHelpers do
  subject do
    class DummyClass
      include UrlHelpers
    end.new
  end

  describe "#add_domain_to_url" do
    it "makes a valid full URL" do
      expect(subject.add_domain_to_url("/test", "http://rssmailer.app")).to eq "http://rssmailer.app/test"
      expect(subject.add_domain_to_url("http://rssmailer.app/test4", "http://rssmailer.app")).to eq "http://rssmailer.app/test4"
      expect(subject.add_domain_to_url("test4", "http://rssmailer.app")).to eq "http://rssmailer.app/test4"
      expect(subject.add_domain_to_url("test4", "https://rssmailer.app")).to eq "https://rssmailer.app/test4"
    end

    it "can handle URI as input" do
      expect(subject.add_domain_to_url("test4", URI("https://rssmailer.app"))).to eq "https://rssmailer.app/test4"
    end

    it "ignores the path on the domain part" do
      expect(subject.add_domain_to_url("test4", URI("https://rssmailer.app/feed/rss.xml"))).to eq "https://rssmailer.app/test4"
    end

    it "handles nil cases" do
      expect(subject.add_domain_to_url(nil, nil)).to eq "/"
      expect(subject.add_domain_to_url(nil, "http://rssmailer.app")).to eq "http://rssmailer.app/"
      expect(subject.add_domain_to_url("/test4", nil)).to eq "/test4"
    end
  end
end
