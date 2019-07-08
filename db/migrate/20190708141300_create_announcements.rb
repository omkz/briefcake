class CreateAnnouncements < ActiveRecord::Migration[5.2]
  def change
    create_table :announcements do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :body
      t.string :show_site_wide
      t.string :announcement_type
      t.string :target
      t.datetime :published_at

      t.timestamps
    end
  end
end
