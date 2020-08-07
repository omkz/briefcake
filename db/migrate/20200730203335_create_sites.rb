class CreateSites < ActiveRecord::Migration[5.2]
  def change
    create_table :sites do |t|
      t.string :url
      t.string :feed_url
      t.references :subscribe_form, foreign_key: true

      t.timestamps
    end
  end
end
