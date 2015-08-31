class OdinClient
  class << self
    def call_user phone_number,text,rule_key,level_number,complaint_id
      response = create_connection.get ('/call'), {phone_number: phone_number,text: text,escalation_rule_key: rule_key,level_number: level_number,complaint_id: complaint_id}
      if response.status == 200
        return true
      end
      return false
    end

    def terminate_pending_calls phone_numbers, complaint_id
      response = create_connection.get ('/terminate_calls'), {phone_numbers: phone_numbers, complaint_id: complaint_id}
      if response.status == 200
        return true
      end
      return false
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
