class FeedBodyTruncation < ActiveRecord::Migration[5.2]
  def change
    add_column :feeds, :truncation, :integer
  end
end
