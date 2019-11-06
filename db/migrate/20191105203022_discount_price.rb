class DiscountPrice < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :discounted_monthly_price, :string
  end
end
