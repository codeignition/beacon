require 'rails_helper'

RSpec.describe EscalationRule, :type => :model do
  it { should have_many(:levels) }
  it { should belong_to(:user) }

  context "uuid" do
    it "should create a new escalation rule with uuid in rule key" do
      er_1 = EscalationRule.create()
      expect(er_1.rule_key).not_to eq nil
    end
    it "should test the uniqueness of uuid" do
      er_2 = EscalationRule.create()
      er_1 = EscalationRule.create()
      expect(er_1.rule_key).not_to eq(er_2.rule_key)
    end
  end
end
