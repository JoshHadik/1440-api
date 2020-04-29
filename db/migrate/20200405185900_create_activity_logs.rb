class CreateActivityLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :activity_logs do |t|
      t.datetime :started_at
      t.datetime :ended_at
      t.string :label
      t.belongs_to :user

      t.timestamps
    end
  end
end
