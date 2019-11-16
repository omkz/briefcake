class RemoveDiscountColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :discounted_monthly_price, :string
    remove_column :users, :coupon, :string
  end
end
