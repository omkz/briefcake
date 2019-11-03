class AddTimeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :send_email_at, :integer
  end
end
