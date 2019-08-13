class AddBuildDurationToSentEmails < ActiveRecord::Migration[5.2]
  def change
    add_column :sent_emails, :compose_duration_in_seconds, :float, default: 0
  end
end
