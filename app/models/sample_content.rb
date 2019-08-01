class SampleContent
  def self.items
    zwarte_koffie_feed = Feed.new({ name: "Timo Kuilder" })
    signal_vs_noise = Feed.new({ name: "Signal vs. Noise" })
    marjolein = Feed.new({ name: "Feisty Favorites" })

    items = [
      {
        "title": "The hardest leadership advice",
        "description": "We all know we’re supposed to “work on the business and not in the business” as a leader… but what holds us back?", "link": "https://m.signalvnoise.com/the-hardest-leadership-advice-to-follow/",
        "feed": signal_vs_noise,
        "publish_date": "2019-07-08T15:34:25.000Z"
      },
      {
        "title": "",
        "description": "Current obsession: drawing cloth and other things with folds and wrinkles.",
        "link": "https://www.instagram.com/p/Bz7N6GBih54/",
        feed: zwarte_koffie_feed,
        "image_url": "https://scontent-ams4-1.cdninstagram.com/vp/a91de7e7c59b0be019a95e99bc4bbb3e/5DE93DFC/t51.2885-15/e35/s1080x1080/65875199_2361690077450419_4165614864286443425_n.jpg?_nc_ht=scontent-ams4-1.cdninstagram.com",
        "publish_date": "2019-07-15T05:14:04.000Z"
      },
      {
        "title": "",
        "description": "Het was echt heerlijk #weekjevakantie maar nu ook weer lekker #backtobusiness",
        "link": "https://www.instagram.com/p/BxZgqNwlk2l/",
        "feed": marjolein,
        "image_url": "https://scontent-ams4-1.cdninstagram.com/vp/766a2d5435ce0b162cad612bf22e675f/5DD1D238/t51.2885-15/e35/32671225_1881352011923271_2006341818538524672_n.jpg?_nc_ht=scontent-ams4-1.cdninstagram.com",
        "publish_date": "2019-07-11T11:30:11.000Z"
      },
    ]

    items.map { |item_json| FeedItem.new(item_json) }
  end

  def self.index
    {
      "Signal vs Noise": 1,
      "Timo Kuilder Instagram": 1,
      "Feisty favorites Instagram": 1
    }
  end
end