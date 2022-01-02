class AddGoodJobProcessess < ActiveRecord::Migration[6.1]
  def change
    create_table :good_job_processes, id: :uuid do |t|
      t.timestamps
      t.jsonb :state
    end
  end
end
