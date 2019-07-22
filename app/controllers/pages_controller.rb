class PagesController < ApplicationController
  def example
    @zwarte_koffie_feed = Feed.new({ name: "Timo Kuilder @ Instagram" })
    @svn = Feed.new({ name: "Signal vs Noise" })
    @lizanne = Feed.new({ name: "lizannevdwerf @ Instagram" })

    items = [
      {
        "title": "",
        "description": "Current obsession: drawing cloth and other things with folds and wrinkles.",
        "link": "https://www.instagram.com/p/Bz7N6GBih54/",
        feed: @zwarte_koffie_feed,
        "image_url": "https://scontent-ams4-1.cdninstagram.com/vp/a91de7e7c59b0be019a95e99bc4bbb3e/5DE93DFC/t51.2885-15/e35/s1080x1080/65875199_2361690077450419_4165614864286443425_n.jpg?_nc_ht=scontent-ams4-1.cdninstagram.com",
        "publish_date": "2019-07-15T05:14:04.000Z"
      },
      { "id": 109,
        "title": "The hardest leadership advice to follow",
        "description": "We all know we’re supposed to “work on the business and not in the business” as a leader… but what holds us back? And, how do you exactly put “stepping away” into practice? “Work on the business, not in the business. Pause. Step back. Take stock. Reflect. “ This is some of the most ubiquitous\u0026#8230; \u003ca class=\"read-more\" href=\"https://m.signalvnoise.com/the-hardest-leadership-advice-to-follow/\"\u003e\u003c/a\u003e", "link": "https://m.signalvnoise.com/the-hardest-leadership-advice-to-follow/",
        "feed": @svn,
        "publish_date": "2019-07-08T15:34:25.000Z" },
      {
        "title": "",
        "description": "WINACTIE ⚡️Ik heb de wonderschone leeftijd van 32 jaar bereikt en dat mag gevierd worden!",
        "link": "https://www.instagram.com/p/BzxlxaMIWdL/",
        "feed": @lizanne,
        "image_url": "https://scontent-amt2-1.cdninstagram.com/vp/e6e788875a1b6f8c8f2dae6689c896f0/5DE2885D/t51.2885-15/e35/p1080x1080/65391008_156860712105887_2203980285800787647_n.jpg?_nc_ht=scontent-amt2-1.cdninstagram.com",
        "publish_date": "2019-07-11T11:30:11.000Z"
      },
    ]

    @feed_items = items.map { |item_json| FeedItem.new(item_json) }

    render "user_mailer/new_items", layout: "mailer"
  end
end
