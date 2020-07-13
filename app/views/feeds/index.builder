xml.opml(version: "1.0") {
    xml.head {
        xml.title("OPML export for #{current_user.name}")
    }

    xml.body {
        xml.outline(text: "RSSMailer Feed", title: "RSSMailer Feed") {
            @feeds.each do |feed|
                xml.outline(type: "rss", text: feed.name, title: feed.name, xmlUrl: feed.feed_url, htmlUrl: feed.url)
            end    
        }
    }

}
