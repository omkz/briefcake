require "rails_helper"

describe FeedItem do
  describe "#body" do
    describe "truncation" do
      it "does not always truncate" do
        feed = create(:feed, truncation: nil)
        item = build(:feed_item, feed: feed, description: long_description)

        expect(item.description).to eq long_description
      end

      it "truncates at a length" do
        feed = create(:feed, truncation: 50)
        item = build(:feed_item, feed: feed, description: long_description)

        expect(item.description).to eq "We're undoubtedly only a little over a month aw..."
      end

      it "removes the whole description" do
        feed = create(:feed, truncation: 0)
        item = build(:feed_item, feed: feed, description: long_description)

        expect(item.description).to eq nil
      end
    end
  end

  describe "#link" do
    it "always has a link" do
      feed = build(:feed, created_at: 1.month.ago, url: "https://feedslink.com")
      without_link = build(:feed_item, link: nil, feed: feed)
      with_link = build(:feed_item, link: "https://itemslink.com", feed: feed)

      expect(with_link.link).to eq "https://itemslink.com"
      expect(without_link.link).to eq "https://feedslink.com"
    end
  end

  def long_description
    <<-HTML
We're undoubtedly only a little over a month away from Apple's big September event, and the company is continuing to make headway on polishing up its next major operating system versions. This week saw a fresh round of betas with some more tweaks and improvements, and we expect things should begin firming up soon as Apple finalizes things and focuses on squashing any final bugs.
&lt;br/&gt;

&lt;br/&gt;
This week also saw official word that Apple Card will launch this month as well as rumors about a 16-inch MacBook Pro, a 10.2-inch iPad, and the 2020 iPhone lineup, while Apple began selling an updated version of LG's 27-inch 5K display. Read on for all of the details on those stories and more.
&lt;br/&gt;

&lt;br/&gt;
&lt;h2&gt;iOS 13 Beta 5 is Out: Here's What's New!&lt;/h2&gt;
&lt;br/&gt;
Another week, &lt;a href="https://www.macrumors.com/2019/07/29/apple-seeds-ios-13-beta-5-to-developers/"&gt;another iOS 13 beta release&lt;/a&gt;! The latest beta for developers and &lt;a href="https://www.macrumors.com/2019/07/30/apple-seeds-ios-13-public-beta-4/"&gt;public testers&lt;/a&gt; includes a handful of new features, changes, and bug fixes. &lt;a href="https://www.macrumors.com/2019/07/29/everything-new-in-ios-13-beta-5/"&gt;We've rounded up everything new&lt;/a&gt;, including a customizable iPad home screen, more precise volume control, and more.
&lt;br/&gt;

&lt;br/&gt;
&lt;img src="http://cdn.macrumors.com/article-new/2019/06/test-iOS-13.jpg" alt="" width="800" height="465" class="aligncenter size-full wp-image-695920" /&gt;
&lt;br/&gt;
Apple also seeded the &lt;a href="https://www.macrumors.com/2019/07/31/apple-seeds-macos-catalina-beta-5-to-developers/"&gt;fifth betas of macOS Catalina&lt;/a&gt;, &lt;a href="https://www.macrumors.com/2019/07/30/apple-seeds-watchos-6-beta-5-to-developers/"&gt;watchOS 6&lt;/a&gt;, and &lt;a href="https://www.macrumors.com/2019/07/29/apple-seeds-tvos-13-beta-5-to-developers/"&gt;tvOS 13&lt;/a&gt; to developers for testing, and there's a &lt;a href="https://www.macrumors.com/2019/08/01/macos-mojave-10-14-6-supplemental-update/"&gt;macOS Mojave Supplemental Update&lt;/a&gt; out that addresses a wake-from-sleep bug.
&lt;br/&gt;

&lt;br/&gt;
&lt;h2&gt;Tim Cook Confirms Apple Card Will Launch in August&lt;/h2&gt;
&lt;br/&gt;
Speaking on Apple's earnings call this week, Apple CEO Tim Cook confirmed that the &lt;a href="https://www.macrumors.com/2019/07/30/apple-card-launching-in-august/"&gt;Apple Card will launch in the United States at some point in August&lt;/a&gt;.
&lt;br/&gt;

&lt;br/&gt;
&lt;img src="http://cdn.macrumors.com/article-new/2019/03/applecardtitanium.jpg" alt="" width="800" height="580" class="aligncenter size-full wp-image-686507" /&gt;
&lt;br/&gt;
iPhone users will be able to sign up for Apple's credit card in the Wallet app within minutes and take advantage of features such as up to 3% in daily cash back, color-coded spending summaries, and no fees. It appears there will be a &lt;a href="https://www.macrumors.com/2019/08/02/apple-card-ipad-app-report/"&gt;dedicated iPad app&lt;/a&gt; for managing Apple Card, as Apple's tablet lacks the centralized Wallet app where the card will be managed on iPhone.
&lt;br/&gt;

&lt;br/&gt;
There will also be a physical, titanium Apple Card for use at stores that do not accept contactless payments like Apple Pay. Finally, Apple's partner for Apple Card, Goldman Sachs, has posted the &lt;a href="https://www.macrumors.com/2019/08/02/goldman-sachs-apple-card-customer-agreement/"&gt;complete customer agreement&lt;/a&gt; with full details on how the card will work, so a launch certainly appears imminent.
&lt;br/&gt;

&lt;br/&gt;
&lt;h2&gt;Apple Begins Selling New 27" LG UltraFine 5K Display&lt;/h2&gt;
&lt;br/&gt;
LG this week &lt;a href="https://www.macrumors.com/2019/07/30/apple-online-store-new-5k-lg-ultrafine-display/"&gt;released a new version of its UltraFine 5K Display&lt;/a&gt; with USB-C connectivity, allowing it to be used with the 2018 iPad Pro for the first time.
&lt;br/&gt;

&lt;br/&gt;
&lt;img src="http://cdn.macrumors.com/article-new/2019/07/lg-ultrafine-5k-display-ipad-pro.jpg" alt="" width="800" height="480" class="aligncenter size-full wp-image-703782" /&gt;
&lt;br/&gt;
In a support document, however, Apple says the display is &lt;a href="https://www.macrumors.com/2019/07/31/new-lg-ultrafine-5k-limited-to-4k-with-ipad-pro/"&gt;limited to 4K at 60Hz when connected to a 2018 iPad Pro&lt;/a&gt; via USB-C. The full 5K resolution requires a 2016 or newer MacBook Pro, a 2018 or newer MacBook Air, a 2017 or newer iMac or iMac Pro, or a 2018 Mac mini.
&lt;br/&gt;

&lt;br/&gt;
&lt;h2&gt;All Three 2020 iPhones Now Expected to Support 5G&lt;/h2&gt;
&lt;br/&gt;
2020 iPhone rumors continue to surface. The latest comes from Ming-Chi Kuo, who &lt;a href="https://www.macrumors.com/2019/07/28/all-2020-iphones-5g-support/"&gt;now expects all three iPhones coming next year to support 5G networks&lt;/a&gt;, not just the higher-end models.
&lt;br/&gt;

&lt;br/&gt;
&lt;img src="http://cdn.macrumors.com/article-new/2019/06/2020-iphone-triad.jpg" alt="" width="616" height="592" class="aligncenter size-full wp-image-698134" /&gt;
&lt;br/&gt;
On our YouTube channel this week, we &lt;a href="https://www.youtube.com/watch?v=t5iizitoP2U"&gt;tested Verizon's 5G network in Chicago&lt;/a&gt;, providing us with a glimpse of what is to come on the iPhone. Be sure to &lt;a href="https://www.youtube.com/user/macrumors?sub_confirmation=1"&gt;subscribe to MacRumors on YouTube&lt;/a&gt; for new Apple videos every week!
&lt;br/&gt;

&lt;br/&gt;
We also once again heard that &lt;a href="https://www.macrumors.com/2019/07/29/kuo-2020-iphones-3d-sensing-rear-cameras/"&gt;2020 iPhones will feature 3D-sensing time-of-flight sensors&lt;/a&gt; added to the rear camera system as Apple continues to dive deeper into augmented reality technology.
&lt;br/&gt;

&lt;br/&gt;
&lt;h2&gt;16-Inch MacBook Pro Said to Feature Narrow Bezels and Launch in Fall&lt;/h2&gt;
&lt;br/&gt;
A report this week claimed that Apple's rumored &lt;a href="https://www.macrumors.com/2019/07/29/16-inch-macbook-pro-narrow-bezels/"&gt;16-inch MacBook Pro will feature ultra-narrow bezels&lt;/a&gt;, suggesting that the notebook could have a similar overall size as the existing 15-inch model.
&lt;br/&gt;

&lt;br/&gt;
&lt;img src="http://cdn.macrumors.com/article-new/2013/09/16inchrmbpcomparison.jpg" alt="" width="800" height="449" class="aligncenter size-full wp-image-695228" /&gt;
&lt;br/&gt;
The 16-inch MacBook Pro is expected to launch in the fall, but rumors have been conflicting about a September or October release date. Rumors suggest the notebook will sport an all-new design and (finally) a &lt;a href="https://www.macrumors.com/2019/07/25/kuo-16-inch-macbook-pro-scissor-keyboard/"&gt;scissor mechanism keyboard&lt;/a&gt;.
&lt;br/&gt;

&lt;br/&gt;
&lt;h2&gt;10.2" iPad Said to Launch in Fall as Successor to 9.7" iPad&lt;/h2&gt;
&lt;br/&gt;
The 16-inch MacBook Pro isn't the only new product expected to launch this fall. Apple is also &lt;a href="https://www.macrumors.com/2019/08/01/10-2-inch-ipad-release-date-rumor/"&gt;widely rumored to release a new 10.2-inch iPad&lt;/a&gt; that will succeed its &amp;#36;329 entry-level 9.7-inch iPad.
&lt;br/&gt;

&lt;br/&gt;
&lt;img src="http://cdn.macrumors.com/article-new/2019/08/9-7-ipad-2019.jpg" alt="" width="800" height="613" class="aligncenter size-full wp-image-703908" /&gt;
&lt;br/&gt;
As with the 16-inch MacBook Pro, there is still some debate as to whether the tablet will be released in September or October.
&lt;br/&gt;

&lt;br/&gt;
&lt;h2&gt;Tim Cook: We Want to Continue Making the Mac Pro in the United States&lt;/h2&gt;
&lt;br/&gt;
Multiple reports have indicated that the new Mac Pro will be manufactured in China, and while that might end up being the case at least initially, Apple CEO Tim Cook this week said that &lt;a href="https://www.macrumors.com/2019/07/30/apple-mac-pro-united-states/"&gt;Apple wants to continue making the computer in the United States&lt;/a&gt;.
&lt;br/&gt;

&lt;br/&gt;
&lt;img src="http://cdn.macrumors.com/article-new/2019/06/2019-mac-pro-side-and-front.jpg" alt="" width="800" height="581" class="aligncenter size-full wp-image-695976" /&gt;
&lt;br/&gt;
Apple filed import tariff exclusion requests for various Mac Pro parts and accessories with the U.S. government last month. In a tweet, President Trump said Apple would not be granted any relief, saying "&lt;a href="https://www.macrumors.com/2019/07/26/donald-trump-mac-pro-tariffs-tweet/"&gt;make them in the USA, no tariffs!&lt;/a&gt;"
&lt;br/&gt;

&lt;br/&gt;
&lt;h3&gt;MacRumors Newsletter&lt;/h3&gt;
&lt;br/&gt;
Each week, we publish an email newsletter like this highlighting the top Apple stories, making it a great way to get a bite-sized recap of the week hitting all of the major topics we've covered and tying together related stories for a big-picture view.
&lt;br/&gt;

&lt;br/&gt;
So if you want to have &lt;a href="https://mailchi.mp/macrumors/august-1-2019"&gt;top stories&lt;/a&gt; like the above recap delivered to your email inbox each week, &lt;b&gt;&lt;a href="http://eepurl.com/OHdUX"&gt;subscribe to our newsletter&lt;/a&gt;&lt;/b&gt;!&lt;br/&gt;&lt;br/&gt;&lt;br/&gt;This article, &amp;quot;&lt;a href="https://www.macrumors.com/2019/08/03/top-stories-ios-13-beta-5-apple-card-august/"&gt;Top Stories: iOS 13 Beta 5, Apple Card Release Date, iPad and MacBook Pro Rumors&lt;/a&gt;&amp;quot; first appeared on &lt;a href="https://www.macrumors.com"&gt;MacRumors.com&lt;/a&gt;&lt;br/&gt;&lt;br/&gt;&lt;a href="https://forums.macrumors.com/threads/top-stories-ios-13-beta-5-apple-card-release-date-ipad-and-macbook-pro-rumors./"&gt;Discuss this article&lt;/a&gt; in our forums&lt;br/&gt;&lt;br/&gt;&lt;div class="feedflare"&gt;
&lt;a href="http://feeds.macrumors.com/~ff/MacRumors-All?a=AZOZk7hYdWE:gVy_KGMrmC8:6W8y8wAjSf4"&gt;&lt;img src="http://feeds.feedburner.com/~ff/MacRumors-All?d=6W8y8wAjSf4" border="0"&gt;&lt;/img&gt;&lt;/a&gt; &lt;a href="http://feeds.macrumors.com/~ff/MacRumors-All?a=AZOZk7hYdWE:gVy_KGMrmC8:qj6IDK7rITs"&gt;&lt;img src="http://feeds.feedburner.com/~ff/MacRumors-All?d=qj6IDK7rITs" border="0"&gt;&lt;/img&gt;&lt;/a&gt;
&lt;/div&gt;&lt;img src="http://feeds.feedburner.com/~r/MacRumors-All/~4/AZOZk7hYdWE" height="1" width="1" alt=""/&gt;
    HTML
  end
end
