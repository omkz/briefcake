class RemoveEmptyFeedUrl < ActiveRecord::Migration[6.1]
  def up
    Feed.where(feed_url: "").delete_all
  end
end
