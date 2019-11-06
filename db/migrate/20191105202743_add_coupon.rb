class AddCoupon < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :coupon, :string, default: ""
  end
end
