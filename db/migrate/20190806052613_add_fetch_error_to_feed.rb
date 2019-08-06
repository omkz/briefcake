class AddFetchErrorToFeed < ActiveRecord::Migration[5.2]
  def change
    add_column :feeds, :fetch_error, :text
  end
end
