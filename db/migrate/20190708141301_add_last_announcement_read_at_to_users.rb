class AddLastAnnouncementReadAtToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :last_announcement_read_at, :datetime
  end
end
