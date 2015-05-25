class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.integer :escalation_rule_id
      t.integer :contact_id
      t.integer :level_number
      t.timestamps
    end
  end
end
