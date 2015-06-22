class AddAirplaneModeDetailsToEscalationRule < ActiveRecord::Migration
  def change
    add_column :escalation_rules, :airplane_mode_on, :boolean
    add_column :escalation_rules, :airplane_mode_start_time, :datetime
    add_column :escalation_rules, :airplane_mode_end_time, :datetime
  end
end
