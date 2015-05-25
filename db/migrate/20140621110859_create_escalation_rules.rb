class CreateEscalationRules < ActiveRecord::Migration
  def change
    create_table :escalation_rules do |t|
      t.string :name
      t.string :rule_key
      t.integer :user_id
      t.timestamps
    end
  end
end
