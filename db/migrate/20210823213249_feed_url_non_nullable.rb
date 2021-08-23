class FeedUrlNonNullable < ActiveRecord::Migration[6.1]
  def change
    validate_check_constraint :feeds, name: "feeds_feed_url_null"
    change_column_null(:feeds, :feed_url, false)
    remove_check_constraint :feeds, name: "feeds_feed_url_null"
  end
end
