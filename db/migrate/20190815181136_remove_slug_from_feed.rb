class RemoveSlugFromFeed < ActiveRecord::Migration[5.2]
  def change
    remove_column :feeds, :slug, :string
  end
end
