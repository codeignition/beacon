class CreateCallLogs < ActiveRecord::Migration
  def change
    create_table :call_logs do |t|
      t.string :phone_number
      t.string :escalation_rule_key
      t.integer :level_number
      t.integer :complaint_id
      t.string :phone_number
      t.datetime :answered_at

      t.timestamps
    end
  end
end
