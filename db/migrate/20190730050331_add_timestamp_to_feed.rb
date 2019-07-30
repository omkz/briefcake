class AddTimestampToFeed < ActiveRecord::Migration[5.2]
  def change
    add_column :feeds, :publish_date_last_sent_item, :datetime
  end
end
