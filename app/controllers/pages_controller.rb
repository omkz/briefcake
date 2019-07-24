class PagesController < ApplicationController
  def stats
    render plain: "#{User.count},#{Feed.count},#{FeedItem.count},#{SentEmail.count}"
  end

  def example
    @zwarte_koffie_feed = Feed.new({ name: "Timo Kuilder" })
    @svn = Feed.new({ name: "" })
    @marjolein = Feed.new({ name: "Feisty Favorites" })

    items = [
      {
        "title": "The hardest leadership advice",
        "description": "We all know we’re supposed to “work on the business and not in the business” as a leader… but what holds us back?", "link": "https://m.signalvnoise.com/the-hardest-leadership-advice-to-follow/",
        "feed": @svn,
        "publish_date": "2019-07-08T15:34:25.000Z"
      },
      {
        "title": "",
        "description": "Current obsession: drawing cloth and other things with folds and wrinkles.",
        "link": "https://www.instagram.com/p/Bz7N6GBih54/",
        feed: @zwarte_koffie_feed,
        "image_url": "https://scontent-ams4-1.cdninstagram.com/vp/a91de7e7c59b0be019a95e99bc4bbb3e/5DE93DFC/t51.2885-15/e35/s1080x1080/65875199_2361690077450419_4165614864286443425_n.jpg?_nc_ht=scontent-ams4-1.cdninstagram.com",
        "publish_date": "2019-07-15T05:14:04.000Z"
      },
      {
        "title": "",
        "description": "Het weekend vloog echt voorbij met natuurlijk een heerlijke zondag met #moederdag. Maar nu weer lekker een hele dag aan het werk met leuke projecten ",
        "link": "https://www.instagram.com/p/BxZgqNwlk2l/",
        "feed": @marjolein,
        "image_url": "https://scontent-amt2-1.cdninstagram.com/vp/a16c73973cb42c974324f7cb2baded8d/5DCEBF77/t51.2885-15/e35/59332429_1470122996456483_2154026295731590905_n.jpg?_nc_ht=scontent-amt2-1.cdninstagram.com",
        "publish_date": "2019-07-11T11:30:11.000Z"
      },
    ]

    @feed_items = items.map { |item_json| FeedItem.new(item_json) }

    render "user_mailer/new_i;tems", layout: "mailer"
  end
end
