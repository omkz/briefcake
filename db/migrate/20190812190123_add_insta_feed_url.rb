class AddInstaFeedUrl < ActiveRecord::Migration[5.2]
  def change
    instagram_feed = Feed.all.filter { |f| f.url.start_with?("https://www.instagram.com/") }
    instagram_feed.each do |f|
      f.update_column :feed_url, f.url
    end
  end
end
