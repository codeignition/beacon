json.array!(@levels) do |level|
  json.extract! level, :id, :escalation_rule_id, :contact_id, :level_number
  json.url level_url(level, format: :json)
end
