class AddVoiceMessageToEscalationRule < ActiveRecord::Migration
  def change
    add_column :escalation_rules, :voice_message, :string, default: ""
  end
end
