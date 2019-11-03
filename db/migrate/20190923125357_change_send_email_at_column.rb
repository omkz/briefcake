class ChangeSendEmailAtColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :send_email_at
    add_column :users, :send_email_at, :string, default: ""
  end
end
