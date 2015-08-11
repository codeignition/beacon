class AddDefaultValueToVoiceMessageAttribute < ActiveRecord::Migration
  def up
    change_column :escalation_rules, :voice_message, :string, :default => "server down"
  end

  def down
    change_column :escalation_rules, :voice_message, :string, :default => ""
  end
end
