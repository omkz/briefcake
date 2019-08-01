class RemoveFeedItems < ActiveRecord::Migration[5.2]
  def change
    drop_table :feed_items
  end
end
