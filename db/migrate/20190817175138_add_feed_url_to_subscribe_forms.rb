class AddFeedUrlToSubscribeForms < ActiveRecord::Migration[5.2]
  def change
    add_column :subscribe_forms, :feed_url, :string
    add_index :subscribe_forms, :slug
  end
end
