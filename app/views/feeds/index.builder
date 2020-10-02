xml.opml(version: "1.0") {
    xml.head {
        xml.title("OPML export from Briefcake")
    }

    xml.body {
        xml.outline(text: "Briefcake Feed", title: "Briefcake Feed") {
            @feeds.each do |feed|
                xml.outline(type: "rss", text: feed.name, title: feed.name, xmlUrl: feed.feed_url, htmlUrl: feed.url)
            end    
        }
    }

}
