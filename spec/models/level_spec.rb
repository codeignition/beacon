require 'rails_helper'

RSpec.describe Level, :type => :model do

  it { should belong_to(:escalation_rule) }
  it { should belong_to(:contact) }
end
