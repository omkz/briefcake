class Unsubscribe < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :unsubscribed_at, :datetime
  end
end
