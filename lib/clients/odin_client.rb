class OdinClient
  class << self
    def call_user phone_number,text,rule_key,level_number,complaint_id
      create_connection.get ('/'), {phone_number: phone_number,text: text,escalation_rule_key: rule_key,level_number: level_number,complaint_id: complaint_id}
    end
  end

  private
  def self.create_connection
    Faraday.new(:url => "http://#{BeaconSettings.odin.host}:#{BeaconSettings.odin.port}") do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end
  end
end
