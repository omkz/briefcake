class FeedUrlNonNullable < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:feeds, :feed_url, false)
  end
end
