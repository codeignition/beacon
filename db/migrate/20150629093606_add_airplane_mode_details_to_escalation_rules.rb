class AddAirplaneModeDetailsToEscalationRules < ActiveRecord::Migration
  def change
    add_column :escalation_rules, :airplane_mode_start_time, :integer
    add_column :escalation_rules, :airplane_mode_end_time, :integer
  end
end
