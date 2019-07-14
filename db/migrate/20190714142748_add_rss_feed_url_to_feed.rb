class AddRssFeedUrlToFeed < ActiveRecord::Migration[5.2]
  def change
    add_column :feeds, :rss_feed_url, :string
  end
end
