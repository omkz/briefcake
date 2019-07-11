class AddImageToFeedItem < ActiveRecord::Migration[5.2]
  def change
    add_column :feed_items, :image_url, :string
  end
end
