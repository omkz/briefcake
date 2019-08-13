class RenameRssFeedUrl < ActiveRecord::Migration[5.2]
  def change
    rename_column :feeds, :rss_feed_url, :feed_url
  end
end
