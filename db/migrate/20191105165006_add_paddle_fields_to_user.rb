class AddPaddleFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :paddle_user_id, :string, default: ""
    add_column :users, :paddle_subscription_id, :string, default: ""
    add_column :users, :paddle_email, :string, default: ""
  end
end
