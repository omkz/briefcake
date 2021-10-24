class PaddleData < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :paddle_data, :jsonb, default: {}
  end
end
