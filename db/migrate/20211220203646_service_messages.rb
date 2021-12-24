class ServiceMessages < ActiveRecord::Migration[6.1]
  def change
    create_table "service_messages" do |t|
      t.string "service_type", null: false
      t.jsonb "data", null: false

      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
