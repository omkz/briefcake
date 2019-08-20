class CreateSubscribeForm < ActiveRecord::Migration[5.2]
  def change
    create_table :subscribe_forms do |t|
      t.references :user
      t.string :url
      t.string :slug
      t.timestamps
    end
  end
end
