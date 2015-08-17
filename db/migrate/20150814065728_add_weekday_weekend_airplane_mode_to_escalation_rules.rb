class AddWeekdayWeekendAirplaneModeToEscalationRules < ActiveRecord::Migration
  def change
    add_column :escalation_rules, :weekday_airplane_mode_on, :boolean
    add_column :escalation_rules, :weekend_airplane_mode_on, :boolean
    add_column :escalation_rules, :weekday_airplane_mode_start_time, :datetime
    add_column :escalation_rules, :weekday_airplane_mode_end_time, :datetime
    add_column :escalation_rules, :weekend_airplane_mode_start_time, :datetime
    add_column :escalation_rules, :weekend_airplane_mode_end_time, :datetime
  end
end
