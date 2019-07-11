class ChangePublishDate < ActiveRecord::Migration[5.2]
  def change
    remove_column :feed_items, :publish_date
    add_column :feed_items, :publish_date, :datetime
  end
end
