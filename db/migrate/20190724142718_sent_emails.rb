class SentEmails < ActiveRecord::Migration[5.2]
  def change
    create_table :sent_emails do |t|
      t.string :subject
      t.string :body
      t.string :sender
      t.string :receiver
      t.references :user
      t.text :body
      t.timestamps
    end
  end
end
