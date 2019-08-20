class SubscribeFormReference < ActiveRecord::Migration[5.2]
  def change
    add_reference :feeds, :subscribe_form
  end
end
