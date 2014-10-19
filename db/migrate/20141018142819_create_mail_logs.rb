class CreateMailLogs < ActiveRecord::Migration
  def change
    create_table :mail_logs do |t|
      t.integer :from_id
      t.integer :to_id

      t.timestamps
    end
  end
end
