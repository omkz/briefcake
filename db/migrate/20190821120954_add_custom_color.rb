class AddCustomColor < ActiveRecord::Migration[5.2]
  def change
    add_column :subscribe_forms, :color, :string, default: ""
  end
end
