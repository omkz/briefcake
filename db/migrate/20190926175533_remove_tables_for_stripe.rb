class RemoveTablesForStripe < ActiveRecord::Migration[5.2]
  def change
    drop_table :sjabloon_charges
    drop_table :sjabloon_coupons
    drop_table :sjabloon_plans
    drop_table :sjabloon_subscriptions
  end
end
