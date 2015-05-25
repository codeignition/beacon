# file name is prefixed with 'a_' to ensure this is loaded first

yaml_path     = File.join Rails.root, 'config', 'beacon.yml.erb'
settings_hash = YAML.load(ERB.new(File.read(yaml_path)).result).to_hash

BeaconSettings = Hashie::Mash.new settings_hash[Rails.env]
