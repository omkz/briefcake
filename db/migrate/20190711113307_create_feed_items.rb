class CreateFeedItems < ActiveRecord::Migration[5.2]
  def change
    create_table :feed_items do |t|
      t.string :title
      t.string :description
      t.string :link
      t.string :publish_date

      t.datetime :sent_at
      t.references :feed, foreign_key: true

      t.timestamps
    end
  end
end
