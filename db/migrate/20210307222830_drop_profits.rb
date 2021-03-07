class DropProfits < ActiveRecord::Migration[6.1]
  def up
    drop_table "profits"
  end
end
