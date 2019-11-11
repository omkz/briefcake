class AddMetaDataToProfit < ActiveRecord::Migration[5.2]
  def change
    add_column :profits, :data, :json
  end
end
