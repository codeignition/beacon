class CreateComplaints < ActiveRecord::Migration
  def change
    create_table :complaints do |t|
      t.string :status
      t.integer :escalation_rule_id
      t.integer :user_id
      t.timestamps
    end
  end
end
