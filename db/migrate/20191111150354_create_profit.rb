class CreateProfit < ActiveRecord::Migration[5.2]
  def change
    create_table :profits do |t|
      t.float :amount
      t.timestamps
    end
  end
end
