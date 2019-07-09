class AddSlugToFeeds < ActiveRecord::Migration[5.2]
  def change
    add_column :feeds, :slug, :string
    add_index :feeds, :slug, unique: true
  end
end
