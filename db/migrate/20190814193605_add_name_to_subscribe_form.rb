class AddNameToSubscribeForm < ActiveRecord::Migration[5.2]
  def change
    add_column :subscribe_forms, :name, :string
  end
end
