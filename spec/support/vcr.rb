class VCR::Cassette
  def sanitized_name
    name.to_s.gsub(/[^\w\-\/]+/, '_').downcase
  end
end

VCR.configure do |config|
  config.cassette_library_dir     = 'spec/cassettes'
  config.default_cassette_options = { record: :new_episodes }
  config.configure_rspec_metadata!
  config.hook_into :webmock
end
