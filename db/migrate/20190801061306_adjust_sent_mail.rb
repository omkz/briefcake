class AdjustSentMail < ActiveRecord::Migration[5.2]
  def change
    add_column :sent_emails, :index, :json
    add_column :sent_emails, :number_of_items, :integer
    remove_column :sent_emails, :body, :string
    remove_column :sent_emails, :sender, :string
  end
end
