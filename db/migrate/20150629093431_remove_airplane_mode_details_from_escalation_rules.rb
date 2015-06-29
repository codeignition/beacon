class RemoveAirplaneModeDetailsFromEscalationRules < ActiveRecord::Migration
  def change
    remove_column :escalation_rules, :airplane_mode_start_time
    remove_column :escalation_rules, :airplane_mode_end_time
  end
end
