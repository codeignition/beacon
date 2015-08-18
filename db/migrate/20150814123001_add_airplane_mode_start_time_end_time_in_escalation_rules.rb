class AddAirplaneModeStartTimeEndTimeInEscalationRules < ActiveRecord::Migration
  def change
    add_column :escalation_rules, :weekday_airplane_mode_start_time, :float
    add_column :escalation_rules, :weekday_airplane_mode_end_time, :float
    add_column :escalation_rules, :weekend_airplane_mode_start_time, :float
    add_column :escalation_rules, :weekend_airplane_mode_end_time, :float
  end
end
